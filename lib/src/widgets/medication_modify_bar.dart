import 'package:ISeeYou/src/models/medication.dart';
import 'package:ISeeYou/src/providers/medication_view_provider.dart';
import 'package:ISeeYou/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:ISeeYou/src/firebase/firebase_auth.dart';
import 'package:provider/provider.dart';

class MedicationModifyBar extends StatefulWidget {
  const MedicationModifyBar({super.key});

  @override
  State<MedicationModifyBar> createState() => _MedicationModifyBarState();
}

class _MedicationModifyBarState extends State<MedicationModifyBar> {
  final TextEditingController _medicationNameController =
      TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();

  bool _isLoading = false;
  bool _isDeleting = false;
  bool _isModifying = false;

  late UserProvider userProvider;
  late MedicationViewProvider medicationViewProvider;

  @override
  void dispose() {
    _medicationNameController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
      userProvider.listenForFirestoreUpdates();
    });
    medicationViewProvider =
        Provider.of<MedicationViewProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: 64,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ]),
        child: Row(
          mainAxisAlignment: width > 600
              ? MainAxisAlignment.end
              : MainAxisAlignment.spaceEvenly,
          children: _isLoading
              ? const [LinearProgressIndicator()]
              : _isDeleting
                  ? [
                      ElevatedButton(
                          onPressed: () {
                            print(medicationViewProvider.isDeleting);
                            setState(() {
                              _isDeleting = false;
                            });
                            medicationViewProvider.setStates(
                                _isDeleting, _isModifying);
                          },
                          child: Column(children: [
                            Icon(Icons.cancel_outlined),
                            Text("Cancel")
                          ]))
                    ]
                  : _isModifying
                      ? [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isModifying = false;
                                });
                                medicationViewProvider.setStates(
                                    _isDeleting, _isModifying);
                              },
                              child: Column(children: [
                                Icon(Icons.cancel_outlined),
                                Text("Cancel")
                              ]))
                        ]
                      : [
                          ElevatedButton(
                              onPressed: () {
                                addMedicationModal(context, height);
                              },
                              child: const Column(
                                children: [Icon(Icons.add), Text("Add")],
                              )),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isDeleting = !_isDeleting;
                                });
                                medicationViewProvider.setStates(
                                    _isDeleting, _isModifying);
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.delete_forever_outlined),
                                  Text("Delete")
                                ],
                              )),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isModifying = !_isModifying;
                                });
                                medicationViewProvider.setStates(
                                    _isDeleting, _isModifying);
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.delete_forever_outlined),
                                  Text("Modify")
                                ],
                              ))
                        ],
        ),
      ),
    );
  }

  Future<dynamic> addMedicationModal(BuildContext context, double height) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("Add Medication"),
                TextField(
                  decoration:
                      const InputDecoration(hintText: "Medication Name"),
                  controller: _medicationNameController,
                ),
                TextField(
                  decoration:
                      const InputDecoration(hintText: "Dosage (add units)"),
                  controller: _dosageController,
                ),
                TextField(
                  decoration:
                      const InputDecoration(hintText: "Frequency (hours)"),
                  controller: _frequencyController,
                ),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                    onPressed: () {
                      addMedication();
                      _medicationNameController.clear();
                      _dosageController.clear();
                      _frequencyController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text("Add"))
              ],
            ),
          );
        });
  }

  Future<void> addMedication() async {
    setState(() {
      _isLoading = true;
    });
    String name = _medicationNameController.text;
    String dosage = _dosageController.text;
    String frequency = _frequencyController.text;

    bool exists = userProvider.user!.medications
        .where((m) => m.name.toLowerCase() == name.toLowerCase())
        .isNotEmpty;

    if (name.isNotEmpty &&
        dosage.isNotEmpty &&
        frequency.isNotEmpty &&
        !exists) {
      await Auth().addMedicationFirebase(Medication(
          name: name,
          dosage: dosage,
          frequency: double.parse(frequency),
          history: []));
    } else if (name.isEmpty || dosage.isEmpty || frequency.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all the fields")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Medication already exists")));
    }

    setState(() {
      _isLoading = false;
    });
  }
}
