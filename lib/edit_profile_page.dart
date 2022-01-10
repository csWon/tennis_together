import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_together/matchList.dart';
import 'package:tennis_together/provider/page_notifier.dart';
import 'package:tennis_together/user_data.dart';

class EditProfile extends StatefulWidget {
  static final pageName = 'EditProfile';
  final UserData userData;

  EditProfile({required this.userData});

  @override
  _EditProfileState createState() => _EditProfileState(userData: userData);
}

class _EditProfileState extends State<EditProfile> {
  final UserData userData;

  _EditProfileState({required this.userData});

  late User user;

  double _currentNTRPValue = 3;

  late String _uid;

  bool isFirst = true;

  final TextEditingController _nickNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _uid = userData.uid!;
    isFirst ? _nickNameController.text = userData.nickName! : null;
    isFirst = false;

    return Material(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
            ),
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         fit: BoxFit.cover, image: AssetImage('assets/CNxj.gif'))),
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
                      _buildTextFormField('Nick Name', _nickNameController),
                      Row(children: [
                        Text('NTRP : '),
                        Slider(
                          activeColor: Colors.yellowAccent,
                          // inactiveColor: Colors.redAccent,
                          value: _currentNTRPValue,
                          max: 7.0,
                          min: 1.0,
                          divisions: 12,
                          label: _currentNTRPValue.toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentNTRPValue = value;
                            });
                          },
                        ),
                      ]),
                      // FutureBuilder(
                      //     future: isFirst?GetCurrentUserData():null,
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot snapshot) {
                      //       // UserData(snapshot);
                      //       _nickNameController.text =
                      //       snapshot.data['nickName'];
                      //       _location = snapshot.data['location'];
                      //       _gender = snapshot.data['gender'];
                      //       _selfIntro = snapshot.data['selfIntroduction'];
                      //       // _currentNTRPValue = snapshot.data['ntrp'];
                      //       user = FirebaseAuth.instance.currentUser!;
                      //       isFirst=false;
                      //       return
                      ElevatedButton(
                          onPressed: () {
                            print('on pressed');
                            print(userData);
                            _EditProfile(context);
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: Text('Edit Profile')), //;
                      // }),
                      SizedBox(
                        height: 300,
                      )
                    ].reversed.toList()),
              ),
            )));
  }

  Future<DocumentSnapshot> GetCurrentUserData() async {
    final _userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    print(_userData.data());
    return _userData;
  }

  TextFormField _buildTextFormField(
      String labelText, TextEditingController ctlr) {
    OutlineInputBorder _border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent, width: 0));

    return TextFormField(
      obscureText: false,
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

  void _EditProfile(BuildContext context) async {
    try {
      var result_2 = await FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .set({
        'nickName': _nickNameController.text,
        'ntrp': _currentNTRPValue,
        'gender': userData.gender,
        'location': userData.address,
        'selfIntroduction': userData.selfIntro,
      });
    } catch (e) {
      print(e);
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('프로필 수정이 완료되었습니다.'),
      duration: const Duration(seconds: 3),
    ));
    var provider2 = Provider.of<PageNotifier>(
        context,
        listen: false);
    provider2.goToOtherPageByIndex(0);
    // Navigator.pop(context);
  }
}
