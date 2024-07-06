import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.constraints,
    required this.message,
    required this.actionTitle,
    required this.actionIcon,
  });

  final BoxConstraints constraints;
  final String message;
  final String actionTitle;
  final Icon actionIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: constraints.maxWidth > 600
            ? constraints.maxWidth * 0.3
            : constraints.maxWidth * 0.45,
        height: constraints.maxWidth > 600
            ? constraints.maxWidth * 0.3
            : constraints.maxWidth * 0.45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            launchUrlString("sms:5194984082?body=$message");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              actionIcon,
              Text(actionTitle),
            ],
          ),
        ),
      ),
    );
  }
}
