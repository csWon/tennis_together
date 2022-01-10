import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySchedulePage extends Page {
  static final pageName = 'MySchedulePage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this, builder: (context) => MySchedule());
  }
}

class MySchedule extends StatefulWidget {
  static const String pageName = 'MySchedule';

  @override
  _MyScheduleState createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Column(children: [
        Text('this is MySchedule page')
      ]),
    ));
  }
}
