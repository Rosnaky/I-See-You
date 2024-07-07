import 'package:flutter/material.dart';

class MedicationModifyBar extends StatefulWidget {
  const MedicationModifyBar({super.key});

  @override
  State<MedicationModifyBar> createState() => _MedicationModifyBarState();
}

class _MedicationModifyBarState extends State<MedicationModifyBar> {
  @override
  Widget build(BuildContext context) {
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
          children: [
            ElevatedButton(
                onPressed: () {},
                child: Column(
                  children: [Icon(Icons.add), Text("Add Meds")],
                ))
          ],
        ),
      ),
    );
  }
}
