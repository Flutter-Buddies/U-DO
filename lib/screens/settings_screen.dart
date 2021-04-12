import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

import 'package:u_do/models/theme.dart';

class SettingsScreen extends StatelessWidget {
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
            title: Text('Dark Theme'),
            value: ThemeEnum.darkTheme.index,
            pref: 'ui_theme',
            onSelect: () {
              Provider.of<ThemeNotifier>(context, listen: false)
                  .setTheme(CustomTheme.mapTheme(ThemeEnum.darkTheme));
            },
          ),
          PrefRadio(
            title: Text('Light Theme'),
            value: ThemeEnum.lightTheme.index,
            pref: 'ui_theme',
            onSelect: () {
              Provider.of<ThemeNotifier>(context, listen: false)
                  .setTheme(CustomTheme.mapTheme(ThemeEnum.lightTheme));
            },
          ),
        ],
      ),
    );
  }
}
