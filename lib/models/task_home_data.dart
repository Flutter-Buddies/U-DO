import 'package:flutter/material.dart';
import 'package:u_do/helpers/db_helper.dart';
import 'dart:core';
import 'task.dart';

class TaskListHome extends ChangeNotifier {
  List<TaskList> taskList = [];

  int get taskLength {
    return taskList.length;
  }

  bool show = false;
  String textTitle;

  void toggleError() {
    show = !show;
    notifyListeners();
  }

  void addTask(String myTaskTitle) async {
    final task = TaskList(id: DateTime.now().toString(), title: myTaskTitle);
    taskList.add(task);
    await DBHelper.insert('task_list', {
      'id': task.id.toString(),
      'title': task.title,
    });
    notifyListeners();
  }

  void deleteTask(TaskList task) async {
    taskList.remove(task);
    await DBHelper.delete('task_list', {
      'id': task.id.toString(),
      'title': task.title,
    });
    notifyListeners();
  }

  //Getting the TaskList from local storage and setting it to taskList Model
  Future<void> fetchTaskListAndSet() async {
    final taskListData = await DBHelper.getData('task_list');
    taskList = taskListData
        .map((task) => TaskList(
              id: task['id'],
              title: task['title'],
            ))
        .toList();
    notifyListeners();
  }
}
