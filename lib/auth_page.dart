import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:tennis_together/forget_pw.dart';
import 'package:tennis_together/matchList.dart';
import 'package:tennis_together/provider/login_notifier.dart';
import 'package:tennis_together/provider/page_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:gender_picker/gender_picker.dart';

import 'package:kpostal/kpostal.dart';

class AuthPage extends Page {
  static final pageName = 'AuthPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this, builder: (context) => AuthWidget());
  }
}
// static final String pageName = 'LoginPage';
// LoginPage({Key key, this.title}) : super(key:key)
// final String title;
// @override
// _AuthPage create() => _AuthPage();

class AuthWidget extends StatefulWidget {
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();
  TextEditingController _cPasswordlController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();

  bool _isPickedMale = true;
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  double _currentNTRPValue = 3;

  String postCode = '-';
  String address = '-';
  String latitude = '-';
  String longitude = '-';
  String kakaoLatitude = '-';
  String kakaoLongitude = '-';

  bool isRegister = false;

  Duration _duration = Duration(milliseconds: 300);
  Curve _curve = Curves.fastOutSlowIn;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/CNxj.gif'))
        ),
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0.0,
          //   leading: BackButton(color: Colors.black),
          // ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Expanded(
                  child: ListView(
                reverse: true,
                padding: EdgeInsets.all(50),
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white54,
                    radius: 36,
                  ),
                  _GetButtonBar(),
                  _GetLoginWidget(),
                  // AnimatedContainer(
                  //     height: isRegister ? 60 : 0,
                  //     duration: _duration,
                  //     curve: _curve,
                  //     child:
                  //         _buildTextFormField(
                  //             'Confirm Password', _cPasswordlController),
                  //     ),
                  // SizedBox(height: 8),
                  // _buildTextFormField(
                  //     'Confirm Password', _cPasswordlController),
                  // _GetGenderPicker(false, false),
                  _GetRegisterWidget(),
                  TextButton(
                      onPressed: isRegister
                          ? null
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPw()));
                            },
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                                isRegister ? FontWeight.w400 : FontWeight.w600,
                            color:
                                isRegister ? Colors.black45 : Colors.black87),
                      )),
                  // SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('빈 입력창이 없습니다.');
                          isRegister ? _register(context) : _login(context);
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.yellowAccent),
                      ),
                      child: Text(isRegister ? 'Register' : 'Login')),
                  SizedBox(height: 8),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.white54,
                    indent: 16,
                    endIndent: 16,
                  ),
                  SizedBox(height: 30),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton('assets/google_logo.png', () {
                        Provider.of<PageNotifier>(context, listen: false)
                            .goToMain();
                      }),
                      // _buildSocialButton('assets/naver_logo.png', () {
                      //   Provider.of<PageNotifier>(context, listen: false)
                      //       .goToMain();
                      // })
                    ],
                  )
                ].reversed.toList(),
              )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _GetLoginWidget() {
    return Container(
        child: Column(children: [
      _buildTextFormField('Email Address', _emailController),
      SizedBox(height: 8),
      _buildTextFormField('Password', _PasswordController),
      SizedBox(height: 8)
    ]));
  }

  Widget _GetRegisterWidget() {
    return AnimatedContainer(
        height: isRegister ? 300 : 0,
        duration: _duration,
        curve: _curve,
        child: Column(
          children: [
            _buildTextFormField('Confirm Password', _cPasswordlController),
            SizedBox(height: 8),
            _buildTextFormField('Nick Name', _nickNameController),
            Row(children: [
              Text('Gender : '),
              Center(child: _GetGenderPicker_2())
            ]),
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
            // Row(
            //   children: [Text('Location : '),_getKakaoAddress(),],
            // ),
            // RangeSlider(
            //   values: _currentRangeValues,
            //   max: 100,
            //   divisions: 5,
            //   labels: RangeLabels(
            //     _currentRangeValues.start.round().toString(),
            //     _currentRangeValues.end.round().toString(),
            //   ),
            //   onChanged: (RangeValues values) {
            //     setState(() {
            //       _currentRangeValues = values;
            //     });
            //   },
            // ),
          ],
        ));
  }

  void _login(BuildContext context) async {
    try {
      final UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _PasswordController.text);

      final User = result.user;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('로그인 성공'), duration: const Duration(seconds: 5)));

      var provider = Provider.of<LoginNotifier>(context, listen: false);
      provider.CheckLogin();

      var provider2 = Provider.of<PageNotifier>(context, listen: false);
      provider2.goToOtherPageByIndex(0);
      // provider2.goToOtherPage(MatchList.pageName);

    } on FirebaseAuthException catch (e) {
      Text txt = const Text('알 수 없는 예외가 발생했습니다.');
      if (e.code == 'user-not-found') {
        txt = Text('등록되지 않은 계정입니다.');
      } else if (e.code == 'wrong-password') {
        txt = Text('틀린 비밀번호가 입력되었습니다.');
      } else if (e.code == 'invalid-email') {
        txt = Text('올바른 이메일을 입력해주세요.');
      } else if (e.code == 'user-disabled:') {
        txt = Text('비활성화된 계정입니다.');
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: txt,
        duration: const Duration(seconds: 5),
      ));
    }
  }

  ButtonBar _GetGenderPicker_2() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: [
        // CircleAvatar(
        //   radius: 30,
        //   backgroundColor: _isPickedMale ? Color(0xff94d500) : null,
        //   child:
        IconButton(
            iconSize: _isPickedMale ? 40 : 24,
            tooltip: '남자',
            onPressed: () {
              setState(() {
                _isPickedMale = true;
                print('_isPickedMale');
              });
            },
            icon: _isPickedMale
                ? Icon(Icons.male_outlined, color: Colors.blue)
                : Icon(Icons.male_outlined)),
        // ),
        // CircleAvatar(
        //   radius: 30,
        // backgroundColor: _isPickedMale ? null:Color(0xff94d500),
        //  child:
        IconButton(
          iconSize: _isPickedMale ? 24 : 40,
          tooltip: '여자',
          onPressed: () {
            setState(() {
              _isPickedMale = false;
              print('_isPickedFemale');
            });
          },
          icon: _isPickedMale
              ? Icon(Icons.female)
              : Icon(
                  Icons.female_outlined,
                  color: Colors.redAccent,
                ),
          //),
        ),
      ],
    );
  }

  Widget _GetGenderPicker(bool showOtherGender, bool alignVertical) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        showOtherGender: showOtherGender,
        verticalAlignedText: alignVertical,
        maleImage: const AssetImage('assets/tennis_male.png'),
        maleText: 'Man',
        femaleImage: const AssetImage('assets/tennis_female.png'),
        femaleText: 'Woman',
        // const AssetImage("assets/images/male.png", package: 'gender_picker'),
        // to show what's selected on app opens, but by default it's Male
        selectedGender: Gender.Male,
        selectedGenderTextStyle: TextStyle(
            fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.blueGrey,
            fontWeight: FontWeight.normal),
        onChanged: (Gender? gender) {
          // setState(() {
          // Provider.of<LoginNotifier>(context, listen: false).SetGender(gender!);
          // });
        },
        //Alignment between icons
        equallyAligned: true,

        animationDuration: Duration(milliseconds: 1000),
        isCircular: false,
        // default : true,
        opacityOfGradient: 0.3,
        padding: const EdgeInsets.all(3),
        size: 60, //default : 40
      ),
    );
  }

  void _register(BuildContext context) async {
    if (_PasswordController.text != _cPasswordlController.text) {
      final snacBar = SnackBar(content: Text('비밀번호가 일치하지 않습니다.'));
      ScaffoldMessenger.of(context).showSnackBar(snacBar);
      return;
    }
    final UserCredential result;
    try {
      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _PasswordController.text);
      User? user = result.user;
      print(user);
      var result_2 =
          FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'nickName': _nickNameController.text,
        'ntrp': _currentNTRPValue,
        'gender':
            _isPickedMale ? Gender.Male.toString() : Gender.Female.toString(),
        'location': '서울시 서초구',
        'selfIntroduction': '반갑습니다 :-)'
      }).catchError(() {
        print('fail');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('부가정보 등록 실패.'),
          duration: const Duration(seconds: 3),
        ));
      });

      print(result_2);

      var provider = Provider.of<LoginNotifier>(context, listen: false);
      provider.CheckLogin();
      var provider2 = Provider.of<PageNotifier>(context, listen: false);
      provider2.goToOtherPageByIndex(0);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('회원가입이 완료되었습니다.'),
        duration: const Duration(seconds: 3),
      ));
    } on FirebaseAuthException catch (e) {
      Text txt = const Text('알 수 없는 예외가 발생했습니다.');
      if (e.code == 'weak-password') {
        txt = const Text('비밀번호가 조건에 부합되지 않습니다.(6자리 이상)');
      } else if (e.code == 'email-already-in-use') {
        txt = const Text('이미 등록된 이메일 주소 입니다.');
      } else if (e.code == 'invalid-email') {
        txt = Text('올바른 이메일을 입력해주세요.');
      } else if (e.code == 'operation-not-allowed') {
        txt = const Text('허용되지 않은 요청입니다.');
        // 전자 메일/암호 계정이 활성화되지 않은 경우 던져집니다. Firebase 콘솔의 Auth 탭에서 이메일/암호 계정을 활성화합니다.
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: txt,
        duration: const Duration(seconds: 3),
      ));
    } catch (e) {
      print(e);
    }
  }

  Container _buildSocialButton(String imagePath, void Function() onPressed) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white54),
      child: IconButton(
          icon: ImageIcon(AssetImage(imagePath)), onPressed: onPressed),
    );
  }

  ElevatedButton _buildElevatedButton(String buttonName) {
    return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        ),
        child: Text(buttonName));
  }

  TextFormField _buildTextFormField(
      String labelText, TextEditingController ctlr) {
    OutlineInputBorder _border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent, width: 0));

    bool _isEmailAddress = (labelText == "Email Address") ? true : false;
    bool _isNickName = (labelText == "Nick Name") ? true : false;
    bool _isPW = (labelText == "Password" || labelText == 'Confirm Password')
        ? true
        : false;
    bool _passwordInVisible = _isPW ? true : false;

    return TextFormField(
      obscureText: _passwordInVisible,
      cursorColor: Colors.black87,
      controller: ctlr,
      validator: (text) {
        //Login Page
        if (!isRegister) {
          if (ctlr == _emailController || ctlr == _PasswordController) {
            if (text == null || text.isEmpty) {
              return '입력창이 비어있습니다.';
            }
          }
        }

        //Register Page
        if (isRegister) {
          if (ctlr == _emailController ||
              ctlr == _PasswordController ||
              ctlr == _cPasswordlController ||
              ctlr == _nickNameController) {
            if (text == null || text.isEmpty) return '입력창이 비어있습니다.';
          }
          if (ctlr == _PasswordController || ctlr == _cPasswordlController) {
            if (_PasswordController.text != _cPasswordlController.text)
              return "같은 비밀번호를 입력해주세요.";
          }
        }
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

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  ButtonBar _GetButtonBar() {
    return ButtonBar(
      children: [
        TextButton(
            onPressed: () {
              setState(() {
                isRegister = false;
                _cPasswordlController.clear();
              });
            },
            child: Text(
              'Login',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: isRegister ? FontWeight.w400 : FontWeight.w600,
                  color: isRegister ? Colors.black45 : Colors.black87),
            )),
        TextButton(
            onPressed: () {
              setState(() {
                isRegister = true;
              });
            },
            child: Text(
              'Register',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: isRegister ? FontWeight.w600 : FontWeight.w400,
                  color: isRegister ? Colors.black87 : Colors.black45),
            )),
      ],
    );
  }

  Widget _getKakaoAddress() {
    return TextButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KpostalView(
              useLocalServer: false,
              localPort: 1024,
              kakaoKey: '{e4349f3e4adcaa89cb704110d3c209da}',
              callback: (Kpostal result) {
                setState(() {
                  this.postCode = result.postCode;
                  this.address = result.address;
                  this.latitude = result.latitude.toString();
                  this.longitude = result.longitude.toString();
                  this.kakaoLatitude = result.kakaoLatitude.toString();
                  this.kakaoLongitude = result.kakaoLongitude.toString();
                });
              },
            ),
          ),
        );
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
      child: Text(
        'Search Address',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
