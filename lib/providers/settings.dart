import 'package:flutter/material.dart';
import "package:todos/models/settings.dart";

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


