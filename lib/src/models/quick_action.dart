import 'package:flutter/material.dart';

class QuickAction {
  final String title;
  final IconData icon;
  final String message;

  QuickAction({required this.title, required this.icon, required this.message});
}

List<QuickAction> quickActions = [
  QuickAction(title: "Notify", icon: Icons.front_hand, message: "Come here"),
  QuickAction(
      title: "Meds",
      icon: Icons.medication_rounded,
      message: "I need my medications"),
  QuickAction(title: "Water", icon: Icons.water_drop, message: "I need water"),
  QuickAction(title: "Food", icon: Icons.food_bank, message: "I need food"),
  QuickAction(
      title: "Bathroom",
      icon: Icons.bathroom,
      message: "I need to use the bathroom"),
  QuickAction(
      title: "Walk",
      icon: Icons.park,
      message: "I want to go somewhere and walk"),
];
