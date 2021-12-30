import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tennis_together/auth_page.dart';
import 'package:tennis_together/profile.dart';
import 'package:tennis_together/forget_pw.dart';

class LoginProfileSwitch extends StatefulWidget {
  @override
  _LoginProfileSwitchState createState() => _LoginProfileSwitchState();
}

class _LoginProfileSwitchState extends State<LoginProfileSwitch> {
  final bool isLogin = FirebaseAuth.instance.currentUser == null ? false : true;

  @override
  Widget build(BuildContext context) {
    return isLogin ? Profile() : AuthWidget();
  }
}
