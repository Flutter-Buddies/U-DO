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
      prefix: 'pref_', defaults: {'ui_theme_mode': 'system'});
  runApp(PrefService(
      service: service,
      child: ChangeNotifierProvider<ThemeModeNotifier>(
          create: (context) => ThemeModeNotifier(
              CustomTheme.mapThemeMode(
            service.get('ui_theme_mode'),
          ),
        ),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeModeNotifier = Provider.of<ThemeModeNotifier>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskData>(
          create: (context) => TaskData(),
        ),
        ChangeNotifierProvider<TaskListHome>(
            create: (context) => TaskListHome(),
        ),
      ],
      child: MaterialApp(
        themeMode: themeModeNotifier.getThemeMode(),
        darkTheme: CustomTheme.darkTheme,
        theme: CustomTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
