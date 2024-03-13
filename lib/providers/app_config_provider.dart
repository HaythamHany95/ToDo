import 'package:flutter/material.dart';

class AppConfiguresProvider extends ChangeNotifier {
  String currentLanguage = 'en';
  ThemeMode currentMode = ThemeMode.system;

  void changeAppLanguage(String newLanguge) {
    if (currentLanguage == newLanguge) {
      return;
    }
    currentLanguage = newLanguge;
    notifyListeners();
  }

  void changeAppMode(ThemeMode newMode) {
    if (currentMode == newMode) {
      return;
    }
    currentMode = newMode;
    notifyListeners();
  }
}
