import 'package:flutter/material.dart';
import 'task.dart';

class TaskListHome extends ChangeNotifier {
  List<TaskList> taskList = [
    TaskList(title: "Rift's Corner", taskIcon: Icon(Icons.alarm)),
    TaskList(title: "Han's Corner", taskIcon: Icon(Icons.run_circle)),
    TaskList(title: "Buy a Mouse", taskIcon: Icon(Icons.mouse))
  ];

  int get taskLength {
    return taskList.length;
  }

  void addTask(String myTaskTitle) {
    final task = TaskList(title: myTaskTitle);
    taskList.add(task);
    notifyListeners();
  }

  void deleteTask(TaskList task) {
    taskList.remove(task);
    notifyListeners();
  }
}
