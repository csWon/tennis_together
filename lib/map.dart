import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tennis_together/provider/login_notifier.dart';
import 'package:provider/provider.dart';
import 'package:tennis_together/provider/login_notifier.dart';

class MapPage extends Page {
  static final pageName = 'MapPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(settings: this, builder: (context) => Map());
  }
}

class Map extends StatefulWidget {
  static String pageName = 'Map';

  String get _pageName => pageName;

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('this is Map page'),
    );
  }
}
