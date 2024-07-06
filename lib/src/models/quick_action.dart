import 'package:flutter/material.dart';

class QuickAction {
  final String title;
  final Icon icon;
  final String message;

  QuickAction({required this.title, required this.icon, required this.message});
}

List<QuickAction> quickActions = [
  QuickAction(
      title: "Notify",
      icon: const Icon(Icons.front_hand),
      message: "Come here"),
  QuickAction(
      title: "Meds",
      icon: const Icon(Icons.medication_rounded),
      message: "I need my medications"),
  QuickAction(
      title: "Water",
      icon: const Icon(Icons.water_drop),
      message: "I need water"),
  QuickAction(
      title: "Food", icon: const Icon(Icons.food_bank), message: "I need food"),
  QuickAction(
      title: "Bathroom",
      icon: const Icon(Icons.bathroom),
      message: "I need to use the bathroom"),
  QuickAction(
      title: "Walk",
      icon: const Icon(Icons.park),
      message: "I want to go somewhere and walk"),
];
