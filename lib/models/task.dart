import 'package:flutter/material.dart';

class Task {
  final String? name;
  bool isDone;

  Task({this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}

class TaskList {
  final String? title;
  Icon? taskIcon = Icon(Icons.alarm);

  TaskList({required this.title, this.taskIcon});
}
