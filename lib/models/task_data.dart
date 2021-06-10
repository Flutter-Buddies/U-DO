import 'package:flutter/foundation.dart';
import 'task.dart';
import 'package:u_do/helpers/db_helper.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [];

  int get taskCount {
    return tasks.length;
  }

  void addTask(String newTaskTitle, String taskListId) {
    final task = Task(
        id: DateTime.now().toString(),
        name: newTaskTitle,
        isDone: false,
        taskListId: taskListId);
    DBHelper.insert('task', {
      'id': task.id.toString(),
      'title': task.name.toString(),
      'isDone': 0,
      'task_list_id': task.taskListId
    });
    tasks.add(task);
    notifyListeners();
  }

  //We update the whole row
  void updateTask(Task task) async{
    task.toggleDone();
    notifyListeners();
   await DBHelper.update('task', {
      'id': task.id.toString(),
      'isDone': task.isDone == true ? 1 : 0,
      'title': task.name.toString(),
      'task_list_id': task.taskListId
    });
  }

  void deleteTask(Task task) async {
    tasks.remove(task);
    await DBHelper.delete('task', {
      'id': task.id.toString(),
      'title': task.name.toString(),
      'isDone': task.isDone == true ? 1 : 0,
      'task_list_id': task.taskListId
    });
    notifyListeners();
  }

  Future<void> fetchTaskAndSet(String taskListId) async {
    final taskList = await DBHelper.getTaskData('task', [taskListId]);
    tasks = taskList
        .map((task) => Task(
            id: task['id'],
            name: task['title'],
            isDone: task['isDone'] == 1 ? true : false,
            taskListId: task['task_list_id']))
        .toList();
    notifyListeners();
  }
}
