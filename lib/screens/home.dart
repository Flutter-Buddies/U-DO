import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_do/models/task_home_data.dart';
import 'package:u_do/models/task.dart';
import 'package:u_do/screens/tasks_screen.dart';

//This widget displays the Home Screen
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Placeholder here"), Text("Placeholder here")],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => addTaskListPopup(context),
          );
        },
        label: Text(
          "Create",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: TaskHome(),
    );
  }
}

//This widgets contains all the TaskList for users
class TaskHome extends StatelessWidget {
  final List<Map> myProducts =
      List.generate(3, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TaskListHome>(builder: (context, tasklist, child) {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 3 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: tasklist.taskLength,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TasksScreen()));
                  },
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.alarm,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              tasklist.taskList[index].title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
                    color: Colors.deepPurpleAccent,
                  ),
                );
              });
        }));
  }
}

//This popup allows the user to add a task
Widget addTaskListPopup(BuildContext context) {
  String title;

  return AlertDialog(
    backgroundColor: Colors.purple,
    title: Center(
      child: Text('Add A Task',
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width / 20,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline)),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextField(
          cursorColor: Colors.white,
          autocorrect: true,
          onChanged: (newTitle) {
            print(newTitle);
            title = newTitle;
          },
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue,
              elevation: 5.0,
              padding: EdgeInsets.all(20.0)),
          onPressed: () {
            Provider.of<TaskListHome>(context, listen: false).addTask(title);
            Navigator.of(context).pop();
          },
          child: Text('Add Task',
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
        ),
      ],
    ),
  );
}
