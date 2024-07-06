import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final List<String> emergencyContacts;
  final String uid;

  FirebaseUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.emergencyContacts,
    required this.uid,
  });

  static FirebaseUser fromSnap(DocumentSnapshot<Object?> snap) {
    List<String> firebaseEmergencyContacts =
        List.from(snap.get('emergencyContacts'));

    return FirebaseUser(
      uid: snap.get("uid"),
      firstName: snap.get('firstName'),
      lastName: snap.get('lastName'),
      email: snap.get('email'),
      phoneNumber: snap.get('phoneNumber'),
      emergencyContacts: firebaseEmergencyContacts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'emergencyContacts': emergencyContacts,
      'uid': uid,
    };
  }
}
