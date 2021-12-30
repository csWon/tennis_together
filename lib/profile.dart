import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

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
                      Container(
                        child: Text("test"),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.signOut();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('로그아웃이 완료되었습니다.'),
                                duration: const Duration(seconds: 5),
                              ));
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: Text('로그아웃')),
                      SizedBox(
                        height: 300,
                      )
                    ].reversed.toList()),
              ),
            )));
  }
}
