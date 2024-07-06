import 'package:ISeeYou/src/firebase/firebase_auth.dart';
import 'package:ISeeYou/src/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  FirebaseUser? _user;
  final _auth = Auth();

  FirebaseUser? get user => _user;

  Future<void> refreshUser() async {
    _user = await _auth.getUserDetails();
    notifyListeners();
  }
}
