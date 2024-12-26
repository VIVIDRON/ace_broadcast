import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.system;

  ThemeMode get getThemeMode => themeMode;

  void setThemeMode(ThemeMode mode){
    themeMode = mode;
    notifyListeners();
  }
}