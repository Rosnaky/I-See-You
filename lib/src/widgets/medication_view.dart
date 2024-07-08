import 'package:ISeeYou/src/providers/user_provider.dart';
import 'package:ISeeYou/src/widgets/medication_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicationView extends StatefulWidget {
  const MedicationView({super.key});

  @override
  State<MedicationView> createState() => _MedicationViewState();
}

class _MedicationViewState extends State<MedicationView> {
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
      userProvider.listenForFirestoreUpdates();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Expanded(
        child: SingleChildScrollView(
            child: userProvider.user?.medications.length != 0
                ? Column(
                    children: userProvider.user?.medications
                            .map((medication) => MedicationCard(
                                  name: medication.name,
                                  dosage: medication.dosage,
                                  frequency: medication.frequency,
                                  history: medication.history,
                                  index: userProvider.user?.meds
                                          .indexOf(medication) ??
                                      0,
                                ))
                            .toList() ??
                        [Text("No medications found")],
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "NO MEDICATIONS FOUND",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  )),
      );
    });
  }
}
