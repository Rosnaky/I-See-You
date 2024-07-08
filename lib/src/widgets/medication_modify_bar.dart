import 'package:flutter/material.dart';

class MedicationModifyBar extends StatefulWidget {
  const MedicationModifyBar({super.key});

  @override
  State<MedicationModifyBar> createState() => _MedicationModifyBarState();
}

class _MedicationModifyBarState extends State<MedicationModifyBar> {
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
          children: [
            ElevatedButton(
                onPressed: () {},
                child: Column(
                  children: [Icon(Icons.add), Text("Add")],
                )),
            ElevatedButton(
                onPressed: () {},
                child: Column(
                  children: [
                    Icon(Icons.delete_forever_outlined),
                    Text("Delete")
                  ],
                )),
            ElevatedButton(
                onPressed: () {},
                child: Column(
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
}
