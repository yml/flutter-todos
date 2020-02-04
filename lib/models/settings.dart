import "package:flutter/material.dart";

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