import 'package:flutter/material.dart';

class Settings {
  ThemeData themeData;

  Settings(){
    this.themeData = ThemeData.light();
  }

  bool isThemeDark() {
    if (themeData == ThemeData.dark()) {
      return true;
    } else {
      return false;
    }
  }

  void toggleTheme(){
    if (isThemeDark()) {
      themeData = ThemeData.light();
    } else {
      themeData = ThemeData.dark();
    }
  }
}

class SettingsModel extends ChangeNotifier {
  final Settings _settings = Settings();


  getTheme() => _settings.themeData;
  isThemeDark()=> _settings.isThemeDark();

  setTheme(ThemeData theme) async{
    _settings.themeData = theme;
  }

  toggleTheme() async {
    _settings.toggleTheme();
    notifyListeners();
  }
}


