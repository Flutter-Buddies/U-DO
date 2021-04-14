import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData mapTheme(String theme) {
    theme = theme.toLowerCase();
    switch (theme) {
      case 'light':
        return lightTheme;
      case 'dark':
        return darkTheme;
      default:
        assert(false, 'Unknown theme $theme');
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
