import 'package:flutter/material.dart';
import 'dart:core';

class Task {
  final String id;
  final String name;
  final String taskListId;
  bool isDone;

  Task({this.id, this.name, this.taskListId, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}

class TaskList {
  final String id;
  final String title;
  Icon taskIcon = Icon(Icons.alarm);

  TaskList({this.id, @required this.title, this.taskIcon});
}
