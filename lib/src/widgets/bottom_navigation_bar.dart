import 'package:ISeeYou/src/models/destinations.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const BottomNavBar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        destinations: destinations
            .map((e) => NavigationDestination(icon: e.icon, label: e.label))
            .toList(),
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected);
  }
}
