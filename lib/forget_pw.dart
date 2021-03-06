import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tennis_together/matchList.dart';

class ForgetPw extends StatefulWidget {
  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

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
                      _buildTextFormField('Email Address', _emailController),
                      ElevatedButton(
                          onPressed: () {
                            _ChangePw(context);
                          },
                          style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: Text('Change password')),
                      SizedBox(
                        height: 300,
                      )
                    ].reversed.toList()),
              ),
            )));
  }

  TextFormField _buildTextFormField(String labelText,
      TextEditingController ctlr) {
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

  void _ChangePw(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
          email: _emailController.text);
      print(_emailController.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
          content: Text('Email??? ???????????? ???????????? ??????????????????.'),
          duration: const Duration(seconds: 3)));


      // provider.CheckLogin();
      //
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => MatchListPage()));
    } on FirebaseAuthException catch (e) {
      Text txt = const Text('??? ??? ?????? ????????? ??????????????????.');

      if (e.code == 'user-not-found') {
        txt = Text('???????????? ?????? ???????????????.');
      } else if (e.code == 'wrong-password') {
        txt = Text('?????? ??????????????? ?????????????????????.');
      } else if (e.code == 'invalid-email') {
        txt = Text('????????? ???????????? ??????????????????.');
      } else if (e.code == 'user-disabled:') {
        txt = Text('??????????????? ???????????????.');
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
        content: txt,
        duration: const Duration(seconds: 5),
      ));
    }
  }
}