import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeMode mapThemeMode(String themeMode) {
    assert(themeMode != null, 'theme mode cannot be null');

    themeMode = themeMode.toLowerCase();
    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        assert(false, 'Unknown theme $themeMode');
        break;
    }
    return ThemeMode.system;
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

class ThemeModeNotifier with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeModeNotifier(this._themeMode);

  getThemeMode() => _themeMode;

  setThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners();
  }
}
