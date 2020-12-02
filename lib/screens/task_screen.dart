import 'package:dome_offline/models/task_model.dart';
import 'package:dome_offline/models/todo_model.dart';
import 'package:dome_offline/services/database_helper.dart';
import 'package:dome_offline/widgets/scroll_behaviour.dart';
import 'package:dome_offline/widgets/todo_widget.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  //Properties
  final task;

  //Constructor
  TaskScreen({@required this.task});
  // TaskScreen({Key key, @required this.id}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DatabaseHelper _dbhelper = DatabaseHelper();

  String _taskTitle = '';
  int _taskId = 0;
  bool _contentVisibility = false;

  //focusNodes
  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;

  @override
  void initState() {
    if (widget.task != null) {
      //set visibilty to true
      _contentVisibility = true;

      _taskTitle = widget.task.taskTitle;
      _taskId = widget.task.id;

      _titleFocus = FocusNode();
      _descriptionFocus = FocusNode();
      _todoFocus = FocusNode();
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    super.dispose();
  }

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
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              // check if the field is not empty
                              if (value != null) {
                                //check if the task is null
                                if (widget.task == null) {
                                  DatabaseHelper _dbhelper = DatabaseHelper();

                                  TaskModel _newTask = TaskModel(
                                    taskTitle: value,
                                  );
                                  _taskId =
                                      await _dbhelper.insertTask(_newTask);
                                  setState(() {
                                    _contentVisibility = true;
                                    _taskTitle = value;
                                  });
                                } else {
                                  await _dbhelper.updateTaskTitle(
                                      _taskId, value);
                                  print('task updated!');
                                }
                                _descriptionFocus.requestFocus();
                              }
                            },
                            textCapitalization: TextCapitalization.sentences,
                            controller: TextEditingController()
                              ..text = _taskTitle,
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
                  Visibility(
                    visible: _contentVisibility,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        focusNode: _descriptionFocus,
                        onSubmitted: (value) {
                          _todoFocus.requestFocus();
                        },
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Task Description',
                          hintStyle: TextStyle(color: Colors.white38),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 24.0),
                        ),
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff211551),
                            letterSpacing: 1.0),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _contentVisibility,
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbhelper.getTodos(_taskId),
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Switch the todo state
                                  },
                                  child: TodoWidget(
                                    isDone: snapshot.data[index].isDone == 0
                                        ? false
                                        : true,
                                    todoText: snapshot.data[index].todoTitle,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: _contentVisibility,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            height: 20.0,
                            margin: EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Image(
                              image: AssetImage('assets/draw_check_mark.png'),
                              color: Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: _todoFocus,
                              onSubmitted: (value) async {
                                // check if the field is not empty
                                if (value != null) {
                                  //check if the task is null
                                  if (widget.task != null) {
                                    DatabaseHelper _dbhelper = DatabaseHelper();

                                    TodoModel _newTodo = TodoModel(
                                      todoTitle: value,
                                      isDone: 0,
                                      taskId: widget.task.id,
                                    );
                                    await _dbhelper.insertTodo(_newTodo);
                                    setState(() {});
                                  }
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                hintText: '(enter your todo list here)',
                                hintStyle: TextStyle(color: Colors.white38),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _contentVisibility,
                child: Positioned(
                  bottom: 32.0,
                  right: 32.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
