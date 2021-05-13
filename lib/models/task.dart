import 'package:flutter/material.dart';
import 'dart:core';

class Task {
  final String id;
  final String? name;
  final String taskListId;
  bool isDone;

  Task(
      {required this.id,
      this.name,
      required this.taskListId,
      this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}

class TaskList {
  final String? title;
  final String? id;
  Icon? taskIcon = Icon(Icons.alarm);

  TaskList({required this.id, required this.title, this.taskIcon});
}
