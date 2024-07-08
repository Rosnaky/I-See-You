import 'package:flutter/material.dart';

class MedicationViewProvider extends ChangeNotifier {
  bool _isDeleting = false;
  bool _isModifying = false;

  bool get isDeleting => _isDeleting;
  bool get isModifying => _isModifying;

  void setStates(bool isDeleting, bool isModifying) async {
    _isDeleting = isDeleting;
    _isModifying = isModifying;
    notifyListeners();
  }
}
