import 'package:dome_offline/models/task_model.dart';
import 'package:dome_offline/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:dome_offline/widgets/todo_widget.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({Key key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                              image: AssetImage('assets/back-arrow.png'),
                              height: 32.0,
                              width: 32.0,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              if (value != null) {
                                DatabaseHelper _dbhelper = DatabaseHelper();

                                TaskModel _newTask = TaskModel(
                                  taskTitle: value,
                                );
                                await _dbhelper.insertTask(_newTask);
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Task Title',
                                hintStyle: TextStyle(color: Colors.white38),
                                border: InputBorder.none),
                            style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff211551),
                                letterSpacing: 1.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Task Description',
                        hintStyle: TextStyle(color: Colors.white38),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                      ),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff211551),
                          letterSpacing: 1.0),
                    ),
                  ),
                  TodoWidget(
                    todoText: 'Create your first TODO',
                    isDone: true,
                  ),
                  TodoWidget(
                    isDone: false,
                  ),
                  TodoWidget(
                    isDone: false,
                  ),
                  TodoWidget(
                    isDone: false,
                  ),
                  TodoWidget(
                    isDone: true,
                  ),
                ],
              ),
              Positioned(
                bottom: 32.0,
                right: 32.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TaskScreen()));
                  },
                  child: Container(
                    height: 56.0,
                    width: 56.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image(
                        image: AssetImage('assets/delete_icon.png'),
                        height: 48.0,
                        width: 48.0,
                        color: Colors.pink[900],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(6, 6),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
