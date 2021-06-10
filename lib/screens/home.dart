import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:u_do/models/task_home_data.dart';
import 'package:u_do/screens/preferences_screen.dart';
import 'package:u_do/screens/tasks_screen.dart';

//This widget displays the Home Screen
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).canvasColor),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PreferencesScreen(),
                  ),
                );
              },
              label: Text('Settings'),
            )
          ],
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
          style: TextStyle(color: Theme.of(context).canvasColor),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: TaskHome(),
    );
  }
}

//This widgets contains all the TaskList for users
class TaskHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).size.width / 20;
    return FutureBuilder(
      future: Provider.of<TaskListHome>(context, listen: false)
          .fetchTaskListAndSet(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<TaskListHome>(
                  child: Center(
                    child: Text("No task group. Add a task"),
                  ),
                  builder: (context, taskListItems, child) {
                    return taskListItems.taskList.length == 0
                        ? child!
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 400,
                                    childAspectRatio: 3 / 3,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: taskListItems.taskLength,
                            itemBuilder: (BuildContext context, index) {
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
                                      Provider.of<TaskListHome>(context,
                                          listen: false)
                                          .deleteTask(
                                          taskListItems.taskList[index]);
                                    },
                                  ),
                                ],
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TasksScreen(
                                                taskListItems
                                                    .taskList[index].id!)));
                                  },
                                  child: Card(
                                    elevation: 5.0,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.alarm,
                                            color: Theme.of(context).canvasColor,
                                            size: 50.0,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Text(
                                              taskListItems
                                                  .taskList[index].title!,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  fontSize: textSize > 10
                                                      ? textSize
                                                      : 10,
                                                  fontWeight: FontWeight.w800),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ]),
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              );
                            });
                  }));
        }
      },
    );
  }
}

//This popup allows the user to add a task
Widget addTaskListPopup(BuildContext context) {
  String? title;
  double textSize = MediaQuery.of(context).size.width / 20;

  return AlertDialog(
    backgroundColor: Theme.of(context).accentColor,
    title: Center(
      child: Text(
        'Add A Task',
        style: TextStyle(
            color: Theme.of(context).canvasColor,
            fontSize: textSize > 10 ? textSize : 10,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline),
      ),
    ),
    content: Consumer<TaskListHome>(
      builder: (context, alert, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: <Widget>[
                TextFormField(
                  cursorColor: Theme.of(context).shadowColor,
                  autocorrect: true,
                  onChanged: (newTitle) {
                    title = newTitle;
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).shadowColor, fontSize: 20.0),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).canvasColor,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: alert.show
                          ? IconButton(
                              icon: Icon(
                                Icons.error,
                                color: Theme.of(context).errorColor,
                              ),
                              onPressed: () {
                                alert.toggleError();
                              },
                            )
                          : null,
                      hintText: "Please do not leave the title blank"),
                ),
                Positioned(
                  top: 130,
                  right: 22,
                  //You can use your own custom tooltip widget over here in place of below Container
                  child: alert.show
                      ? Container(
                          width: 270,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            border: Border.all(
                                color: Theme.of(context).errorColor,
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: Text(
                              "Please enter a Title!",
                            ),
                          ),
                        )
                      : Container(),
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).splashColor,
                  elevation: 5.0,
                  padding: EdgeInsets.all(20.0)),
              onPressed: () {
                if (title != null) {
                  Provider.of<TaskListHome>(context, listen: false)
                      .addTask(title);
                  Navigator.of(context).pop();
                  alert.show = false;
                } else {
                  alert.toggleError();
                }
              },
              child: Text(
                'Add Task',
                style: TextStyle(
                    color: Theme.of(context).canvasColor, fontSize: 20.0),
              ),
            ),
          ],
        );
      },
    ),
  );
}
