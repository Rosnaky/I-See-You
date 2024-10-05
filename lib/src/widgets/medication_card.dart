import 'package:ISeeYou/src/firebase/firebase_auth.dart';
import 'package:ISeeYou/src/providers/medication_view_provider.dart';
import 'package:ISeeYou/src/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicationCard extends StatefulWidget {
  MedicationCard(
      {super.key,
      required this.name,
      required this.dosage,
      required this.frequency,
      required this.history,
      required this.index});

  final String name;
  final String dosage;
  final double frequency;
  final List<DateTime> history;
  final int index;

  @override
  State<MedicationCard> createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  String get name => widget.name;
  String get dosage => widget.dosage;
  double get frequency => widget.frequency;
  List<DateTime> get history => widget.history;
  int get index => widget.index;

  late bool _isExpanded;
  late MedicationViewProvider medicationViewProvider;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
    medicationViewProvider =
        Provider.of<MedicationViewProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _isExpanded = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationViewProvider>(
        builder: (context, medicationViewProvider, _) {
      return Column(
        children: [
          ListTile(
            selectedColor: Theme.of(context).listTileTheme.selectedColor,
            style: Theme.of(context).listTileTheme.style,
            title: Text(name.toUpperCase(),
                style: const TextStyle(color: Colors.red)),
            subtitle:
                Text("\nDosage: $dosage\nFrequency: once per $frequency hours"),
            trailing: medicationViewProvider.isDeleting
                ? ElevatedButton(
                    onPressed: () {
                      Auth().deleteMedication(index);
                    },
                    child: Icon(Icons.delete_forever_outlined))
                : medicationViewProvider.isModifying
                    ? ElevatedButton(
                        onPressed: () {
                          modifyModal(context);
                        },
                        child: Icon(Icons.edit))
                    : Wrap(spacing: 8, children: [
                        ElevatedButton(
                          onPressed: () => setState(() {
                            _isExpanded = !_isExpanded;
                          }),
                          child: Column(
                            children: [
                              Text("History: ${history.length}"),
                              Icon(_isExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => addLog(),
                          child: const Column(
                            children: [
                              Text("Log Dose"),
                              Icon(Icons.add_circle_outline),
                            ],
                          ),
                        ),
                      ]),
          ),
          if (_isExpanded)
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.surface,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: SingleChildScrollView(
                  child: Column(
                    children: history
                        .map((date) => ListTile(
                              title: Text(
                                  "${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute}"),
                            ))
                        .toList(),
                  ),
                ),
              ),
            )
        ],
      );
    });
  }

  Future<dynamic> modifyModal(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController dosageController =
        TextEditingController(text: dosage);
    TextEditingController frequencyController =
        TextEditingController(text: frequency.toString());

    frequencyController.text = frequency.toString();
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                TextFieldInput(
                  hintText: "Name",
                  controller: nameController,
                  textInputType: TextInputType.text,
                ),
                TextFieldInput(
                  hintText: "Dosage",
                  controller: dosageController,
                  textInputType: TextInputType.text,
                ),
                TextFieldInput(
                  hintText: "Frequency per hour",
                  controller: frequencyController,
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    Auth().modifyMedication(
                        index,
                        nameController.text,
                        dosageController.text,
                        double.parse(frequencyController.text));
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Save"),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void addLog() async {
    final DateTime now = DateTime.now();
    setState(() {
      history.add(now);
    });
    await Auth().setMedicationHistory(index, history);
  }
}
