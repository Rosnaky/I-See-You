import 'package:flutter/material.dart';

class Destination {
  final String label;
  final Icon icon;

  Destination({required this.label, required this.icon});
}

final List<Destination> destinations = [
  Destination(label: "Notify", icon: Icon(Icons.notifications_active_outlined)),
  Destination(label: "Meds", icon: Icon(Icons.medication_outlined))
];
