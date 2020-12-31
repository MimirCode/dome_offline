import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  // Properties
  final taskTitle;
  final taskDescription;

  //constructor
  const TaskCardWidget({Key key, this.taskTitle, this.taskDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            taskTitle ?? "(Unnamed task)",
            style: TextStyle(
              fontSize: 22.0,
              color: Color(0xff211551),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              taskDescription ?? '',
              style:
                  TextStyle(fontSize: 16.0, color: Colors.black54, height: 1.5),
            ),
          )
        ],
      ),
    );
  }
}
