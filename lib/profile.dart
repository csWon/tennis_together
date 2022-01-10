import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_together/edit_profile_page.dart';
import 'package:tennis_together/provider/login_notifier.dart';
import 'package:tennis_together/provider/page_notifier.dart';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tennis_together/user_data.dart';

import 'matchList.dart';

class Profile extends StatefulWidget {
  static final pageName = 'Profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  late File _image;
  // var userData;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('assets/CNxj.gif'))),
            child: Scaffold(
              // appBar: AppBar(
              //   backgroundColor: Colors.transparent,
              //   elevation: 0.0,
              //   leading: BackButton(color: Colors.black),
              // ),
              body: FutureBuilder(
                  future: test(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }

                    String? _email = user?.email;
                    String? _nickName = snapshot.data['nickName'];
                    String? _location = snapshot.data['location'];
                    String? _selfIntro = snapshot.data['selfIntroduction'];
                    double _ntrp = snapshot.data['ntrp'];
                    String _gender = snapshot.data['gender'] == 'Gender.Female'
                        ? '남자'
                        : '여자';

                    return Form(
                      child: ListView(
                          // reverse: true,
                          padding: EdgeInsets.all(50),
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 80,
                              child:ClipRRect(
                                  borderRadius: new BorderRadius.circular(100.0),
                                  child: Image.asset('assets/blankUser.png')),
                            ),
                            // CircleAvatar(
                            //   backgroundImage:
                            //   (_image != null) ? FileImage(_image) : NetworkImage(""),
                            //   radius: 30,
                            // ),
                            // ElevatedButton(
                            //   child: Text("Gallery"),
                            //   onPressed: () {
                            //     _uploadImageToStorage(ImageSource.gallery);
                            //   },
                            // ),
                            SizedBox(height: 30),
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email : $_email"),
                                SizedBox(height: 8),
                                Text("Nick Name : $_nickName"),
                                SizedBox(height: 8),
                                Text("Gender : $_gender"),
                                SizedBox(height: 8),
                                Text("NTRP : $_ntrp"),
                                SizedBox(height: 8),
                                TextButton(
                                    onPressed:
                                          () {
                                            // var provider2 = Provider.of<PageNotifier>(context, listen: false);
                                            // provider2.goToOtherPage('EditProfile');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditProfile(
                                                    userData : UserData(
                                                  uid: user?.uid,
                                                      ntrp:_ntrp,
                                                      nickName: _nickName,
                                                      gender: _gender,
                                                      address: _location,
                                                      selfIntro: _selfIntro,
                                                ))));
                                      },
                                      // var result_2 = FirebaseFirestore.instance.collection('users').doc(
                                      //     user?.uid).set({
                                      //   'nickName': _nickNameController.text,
                                      //   'ntrp': _currentNTRPValue,
                                      //   'gender': _isPickedMale? Gender.Male.toString():Gender.Female.toString(),
                                      //   'location': '서울시 서초구',
                                      //   'selfIntroduction': '반갑습니다 :-)'
                                      // });

                                    child: Text(
                                      'Edit Profile',
                                    ))
                              ],
                            )),
                            // Container(
                            //   child: Text("매너 평점 : 10.0"),
                            // ),
                            // Container(
                            //   child: Text("활동 지역 : 서울시 강남구"),
                            // ),
                            SizedBox(height: 30),

                            ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await FirebaseAuth.instance.signOut();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('로그아웃이 완료되었습니다.'),
                                      duration: const Duration(seconds: 5),
                                    ));

                                    var provider = Provider.of<LoginNotifier>(
                                        context,
                                        listen: false);
                                    provider.CheckLogin();
                                    var provider2 = Provider.of<PageNotifier>(
                                        context,
                                        listen: false);
                                    provider2.goToOtherPageByIndex(0);
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green),
                                ),
                                child: Text('로그아웃')),
                            SizedBox(
                              height: 30,
                            )
                          ] //.reversed.toList()
                          ),
                    );
                  }),
            )));
  }

  Future<DocumentSnapshot> test() async {
    final _userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    // print(_userData.data());
    return _userData;
  }

  // void _uploadImageToStorage(ImageSource source) async {
  //   File image = await ImagePicker.pickImage(source: source);
  //
  //   if (image == null) return;
  //   setState(() {
  //     _image = image;
  //   });
  // }

  // Widget _buildSaveButton () {
  //   return IconButton(
  //     icon: Icon(Icons.save),
  //     onPressed: _image == null ? null : () async => _save(),
  //   );
  // }

  Widget _BuildProfileCard() {
    String? email = user?.email;

    return Card(
      child: ListTile(
        // leading: Image.network(user?.photoUrl),
        title: Text('Name'),
        subtitle: Text('email test'),
        trailing: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, '/profile-edit', arguments: user);
          },
        ),
      ),
    );
  }
}
