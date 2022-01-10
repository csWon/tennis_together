import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_together/auth_page.dart';
import 'package:tennis_together/profile.dart';
import 'package:tennis_together/forget_pw.dart';
import 'package:tennis_together/provider/login_notifier.dart';

class LoginProfileSwitchPage extends Page {
  static final pageName = 'LoginProfileSwitchPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this, builder: (context) => LoginProfileSwitch());
  }
}

class LoginProfileSwitch extends StatefulWidget {
  final String state = '로그인';

  String GetStr(){
    String str = FirebaseAuth.instance.currentUser == null ? '로그인' : '프로필';
    return str;
  }
  @override
  _LoginProfileSwitchState createState() => _LoginProfileSwitchState();
}

class _LoginProfileSwitchState extends State<LoginProfileSwitch> {
  final bool isLogin = FirebaseAuth.instance.currentUser == null ? false : true;

  @override
  Widget build(BuildContext context) {
    Widget tmp = isLogin ? Profile() : AuthWidget();

    return tmp;
  }
}


