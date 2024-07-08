import 'package:firebase_core/firebase_core.dart';

class Medication {
  final String name;
  final String dosage;
  final double frequency;
  List<DateTime> _history;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required List<DateTime> history,
  }) : _history = history;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'history': _history.map((e) => e.toIso8601String()).toList(),
    };
  }

  List<DateTime> get history => _history;

  set history(List<DateTime> value) {
    _history = value;
  }

  static Medication fromJson(Map<String, dynamic> json) {
    List<DateTime> firebaseHistory =
        List.from(json['history']).map((e) => DateTime.parse(e)).toList();

    return Medication(
      name: json['name'],
      dosage: json['dosage'],
      frequency: double.parse(json['frequency']),
      history: firebaseHistory,
    );
  }
}
