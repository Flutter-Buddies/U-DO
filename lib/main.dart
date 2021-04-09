import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task_data.dart';
import 'screens/home.dart';
import 'models/task_home_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskData>(create: (context) => TaskData()),
        ChangeNotifierProvider<TaskListHome>(
            create: (context) => TaskListHome()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
          accentColor: Colors.deepPurpleAccent,
          canvasColor: Colors.white,
          shadowColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
