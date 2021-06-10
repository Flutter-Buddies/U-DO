import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pref/pref.dart';
import 'package:provider/provider.dart';
import 'package:u_do/bloc/bloc/theme_bloc.dart';

import 'models/task_data.dart';
import 'models/task_home_data.dart';
import 'helpers/theme.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var service = await PrefServiceShared.init(
      prefix: 'pref_', defaults: {'ui_theme_mode': 'system'});
  runApp(
    PrefService(
      service: service,
      child: BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskListHome>(
            create: (context) => TaskListHome()),
        ChangeNotifierProvider<TaskData>(create: (context) => TaskData()),
      ],
      child: MaterialApp(
        themeMode: context.watch<ThemeBloc>().theme,
        darkTheme: CustomTheme.darkTheme,
        theme: CustomTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
