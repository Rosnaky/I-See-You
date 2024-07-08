import 'dart:convert';

import 'package:ISeeYou/src/models/medication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final List<String> emergencyContacts;
  final String uid;
  final List<Medication> medications;

  FirebaseUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.emergencyContacts,
    required this.uid,
    required this.medications,
  });

  List<Medication> get meds => medications;

  static FirebaseUser fromSnap(DocumentSnapshot<Object?> snap) {
    List<String> firebaseEmergencyContacts =
        List.from(snap.get('emergencyContacts'));

    List<Medication> firebaseMedications =
        List.from(snap.get('medications').map((e) {
      Medication medication = Medication.fromJson(e);
      medication.history.sort((a, b) => b.compareTo(a));
      return medication;
    }));

    return FirebaseUser(
        uid: snap.get("uid"),
        firstName: snap.get('firstName'),
        lastName: snap.get('lastName'),
        email: snap.get('email'),
        phoneNumber: snap.get('phoneNumber'),
        emergencyContacts: firebaseEmergencyContacts,
        medications: firebaseMedications);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'emergencyContacts': emergencyContacts,
      'uid': uid,
      'medications': medications.map((e) => e.toJson()).toList(),
    };
  }
}
