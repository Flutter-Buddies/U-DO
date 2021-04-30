import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

import 'package:u_do/helpers/theme.dart';

class PreferencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: PrefPage(
        children: [
          PrefTitle(title: Text('Theme')),
          PrefRadio(
            title: Text('System'),
            value: 'system',
            pref: 'ui_theme_mode',
            onSelect: () {
              Provider.of<ThemeModeNotifier>(context, listen: false)
                  .setThemeMode(
                CustomTheme.mapThemeMode('system'),
              );
            },
          ),
          PrefRadio(
            title: Text('Dark Theme'),
            value: 'dark',
            pref: 'ui_theme_mode',
            onSelect: () {
              Provider.of<ThemeModeNotifier>(context, listen: false)
                  .setThemeMode(
                CustomTheme.mapThemeMode('dark'),
              );
            },
          ),
          PrefRadio(
            title: Text('Light Theme'),
            value: 'light',
            pref: 'ui_theme_mode',
            onSelect: () {
              Provider.of<ThemeModeNotifier>(context, listen: false)
                  .setThemeMode(
                CustomTheme.mapThemeMode('light'),
              );
            },
          ),
        ],
      ),
    );
  }
}
