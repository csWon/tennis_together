import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeLogin extends StatefulWidget {
  static const String pageName = 'WelcomeLogin';
  @override
  _WelcomeLoginState createState() => _WelcomeLoginState();
}

class _WelcomeLoginState extends State<WelcomeLogin> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('assets/CNxj.gif'))),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: BackButton(color: Colors.black),
              ),
              body: Form(
                child: ListView(
                    reverse: true,
                    padding: EdgeInsets.all(50),
                    children: [
                      Text('환영합니다!'),
                      SizedBox(
                        height: 300,
                      )
                    ].reversed.toList()),
              ),
            )));
  }

  TextFormField _buildTextFormField(
      String labelText, TextEditingController ctlr) {
    OutlineInputBorder _border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent, width: 0));

    bool _isEmailAddress = (labelText == "Email Address") ? true : false;
    bool _passwordInVisible = !_isEmailAddress;

    return TextFormField(
      obscureText: _passwordInVisible,
      cursorColor: Colors.black87,
      controller: ctlr,
      validator: (text) {
        return null;
      },
      decoration: InputDecoration(
          // icon: _isEmailAddress? Icon(Icons.email): Icon(Icons.vpn_key),
          hintText: labelText,
          filled: true,
          fillColor: Colors.white70,
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          labelStyle: TextStyle(color: Colors.white)),
    );
  }
}
