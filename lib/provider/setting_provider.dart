import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  RegExp regExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');

  emailValidator(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  passwordValidator(String value) {
    if (value.length < 8 || value.length >= 64) {
      return "";
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return '';
    } else if (!RegExp(r'\d').hasMatch(value)) {
      return '';
    } else {
      return null;
    }
  }

  void hidePass() {
    _isVisible = !_isVisible;

    notifyListeners();
  }
}
