import 'package:flutter/material.dart';

enum ThemeEnum { lightTheme, darkTheme }

class CustomTheme {
  static ThemeData mapTheme(dynamic theme) {
    if (theme is int) {
      theme = ThemeEnum.values[theme];
    } else {
      assert(theme is ThemeEnum, 'Should only pass in an int or CustomTheme');
    }

    switch (theme) {
      case ThemeEnum.lightTheme:
        return lightTheme;
      case ThemeEnum.darkTheme:
        return darkTheme;
      default:
        break;
    }
    return darkTheme; // personal preference
  }

  static var lightTheme = ThemeData(
      primaryColor: Colors.lightBlueAccent,
      accentColor: Colors.deepPurpleAccent,
      canvasColor: Colors.white,
      shadowColor: Colors.black,
      errorColor: Colors.red,
      splashColor: Colors.lightBlue,
      brightness: Brightness.light);

  static var darkTheme = ThemeData(
      primaryColor: Colors.teal,
      accentColor: Colors.tealAccent,
      canvasColor: Colors.black54,
      shadowColor: Colors.black,
      errorColor: Colors.red,
      splashColor: Colors.lightBlue,
      brightness: Brightness.dark);
}

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
