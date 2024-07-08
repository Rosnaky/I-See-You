import 'package:ISeeYou/src/firebase/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicationCard extends StatefulWidget {
  const MedicationCard(
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

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
  }

  @override
  void dispose() {
    _isExpanded = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          selectedColor: Theme.of(context).listTileTheme.selectedColor,
          style: Theme.of(context).listTileTheme.style,
          title: Text(name.toUpperCase(),
              style: const TextStyle(color: Colors.red)),
          subtitle:
              Text("\nDosage: $dosage\nFrequency: once per $frequency hours"),
          trailing: Wrap(spacing: 8, children: [
            ElevatedButton(
              onPressed: () => setState(() {
                _isExpanded = !_isExpanded;
              }),
              child: Column(
                children: [
                  Text("History: ${history.length}"),
                  Icon(
                      _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down)
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
          SizedBox(
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
          )
      ],
    );
  }

  void addLog() async {
    final DateTime now = DateTime.now();
    setState(() {
      history.add(now);
    });
    await Auth().setMedicationHistory(index, history);
  }
}
