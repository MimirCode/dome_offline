import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  //Properties
  final String todoText;
  final bool isDone;

  //Constructor
  const TodoWidget({
    Key key,
    this.todoText,
    @required this.isDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
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
              color: isDone ? Colors.black87 : Colors.transparent,
            ),
          ),
          Flexible(
            child: Text(
              todoText ?? '(Empty TODO)',
              style: TextStyle(
                  decoration:
                      isDone ? TextDecoration.lineThrough : TextDecoration.none,
                  fontSize: 16.0,
                  color: isDone ? Color(0x80211551) : Color(0xff211551),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
