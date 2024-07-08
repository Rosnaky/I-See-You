import 'package:ISeeYou/src/firebase/firebase_auth.dart';
import 'package:ISeeYou/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  FirebaseUser? _user;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _auth = Auth();

  FirebaseUser? get user => _user;

  Future<void> refreshUser() async {
    _user = await _auth.getUserDetails();
    notifyListeners();
  }

  Future<void> listenForFirestoreUpdates() async {
    final userDoc =
        _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid);

    userDoc.snapshots().listen((snap) {
      refreshUser();
    });
  }
}
