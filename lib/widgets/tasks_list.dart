import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:u_do/screens/add_task_screen.dart';
import 'package:u_do/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:u_do/models/task_data.dart';
import 'package:u_do/models/task.dart';

class TasksList extends StatelessWidget {
  final String task_list_id;
  TasksList(this.task_list_id);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: null,
      future: Provider.of<TaskData>(context, listen: false)
          .fetchTaskAndSet(task_list_id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.hasError.toString());
          return Center(
            child: Text("Uh,oh! Something wrong."),
          );
        } else //
        {
          return Consumer<TaskData>(
            child: Center(
              child: Text('No Tasks.Start adding some.'),
            ),
            builder: (context, taskData, child) {
              return taskData.tasks.length == 0
                  ? child!
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        final task = taskData.tasks[index];
                        return Slidable(
                          key: Key(index.toString()),
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                Provider.of<TaskData>(context,
                                    listen: false)
                                    .deleteTask(task);
                              },
                            ),
                          ],
                          child: TaskTile(
                            taskTitle: task.name,
                            isChecked: task.isDone,
                          ),
                        );
                      },
                      itemCount: taskData.taskCount,
                    );
            },
          );
        }
      },
    );
  }
}
