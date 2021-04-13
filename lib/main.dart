import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';

import 'models/task_data.dart';
import 'models/task_home_data.dart';
import 'helpers/theme.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var service = await PrefServiceShared.init(
      prefix: 'pref_', defaults: {'ui_theme': 'dark'});
  runApp(PrefService(
      service: service,
      child: ChangeNotifierProvider<ThemeNotifier>(
          create: (context) =>
              ThemeNotifier(CustomTheme.mapTheme(service.get('ui_theme'))),
          child: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskData>(create: (context) => TaskData()),
        ChangeNotifierProvider<TaskListHome>(
            create: (context) => TaskListHome()),
      ],
      child: MaterialApp(
        theme: themeNotifier.getTheme(),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
