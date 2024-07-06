import 'package:ISeeYou/src/models/quick_action.dart';
import 'package:ISeeYou/src/widgets/quick_action_card.dart';
import 'package:flutter/material.dart';

class QuickActionScreen extends StatefulWidget {
  const QuickActionScreen({super.key});

  @override
  State<QuickActionScreen> createState() => _QuickActionScreenState();
}

class _QuickActionScreenState extends State<QuickActionScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: constraints.maxWidth * 0.01,
              runSpacing: constraints.maxWidth * 0.01,
              children: quickActions
                  .map((e) => QuickActionCard(
                      constraints: constraints,
                      message: e.message,
                      actionTitle: e.title,
                      actionIcon: e.icon))
                  .toList(),
            ),
          ),
        );
      }),
    );
  }
}
