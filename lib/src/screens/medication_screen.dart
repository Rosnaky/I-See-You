import 'package:ISeeYou/src/widgets/medication_modify_bar.dart';
import 'package:ISeeYou/src/widgets/medication_view.dart';
import 'package:flutter/material.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [MedicationModifyBar(), MedicationView()],
    );
  }
}
