import 'package:dome_offline/screens/task_screen.dart';
import 'package:dome_offline/services/database_helper.dart';
import 'package:dome_offline/shared/constants.dart';
import 'package:dome_offline/widgets/scroll_behaviour.dart';
import 'package:flutter/material.dart';
import 'package:dome_offline/widgets/card_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBGColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white54,
                        radius: 35.0,
                        child: Text(
                          'Do',
                          style: TextStyle(
                              fontSize: 48.0,
                              color: Colors.pink[900],
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Text(
                        'Me!',
                        style: TextStyle(fontSize: 28.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(140, 0, 0, 14),
                        child: Image(
                          image: AssetImage('assets/dome_logo.png'),
                          height: 96.0,
                          width: 96.0,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: FutureBuilder(
                    initialData: [],
                    future: _databaseHelper.getTasks(),
                    builder: (context, snapshot) {
                      return ScrollConfiguration(
                        behavior: NoGlowBehaviour(),
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskScreen(
                                      task: snapshot.data[index],
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: TaskCardWidget(
                                taskTitle: snapshot.data[index].taskTitle,
                                taskDescription:
                                    snapshot.data[index].description,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ))
                ],
              ),
              Positioned(
                bottom: 32.0,
                right: 12.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskScreen(
                          task: null,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 56.0,
                    width: 56.0,
                    child: Image(
                      image: AssetImage('assets/add_icon.png'),
                      color: Colors.white54,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.indigo[600],
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(4, 4),
                            blurRadius: 6.0,
                          ),
                        ]),
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
