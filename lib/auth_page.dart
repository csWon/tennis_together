import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_together/forget_pw.dart';
import 'package:tennis_together/provider/page_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tennis_together/welcome_login.dart';

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

  bool isRegister = false;

  Duration _duration = Duration(milliseconds: 300);
  Curve _curve = Curves.fastOutSlowIn;

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
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                reverse: true,
                padding: EdgeInsets.all(50),
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white54,
                    radius: 36,
                  ),
                  ButtonBar(
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
                                fontWeight: isRegister
                                    ? FontWeight.w400
                                    : FontWeight.w600,
                                color: isRegister
                                    ? Colors.black45
                                    : Colors.black87),
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
                                fontWeight: isRegister
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isRegister
                                    ? Colors.black87
                                    : Colors.black45),
                          )),
                    ],
                  ),
                  _buildTextFormField('Email Address', _emailController),
                  SizedBox(height: 8),
                  _buildTextFormField('Password', _PasswordController),
                  SizedBox(height: 8),
                  AnimatedContainer(
                      height: isRegister ? 60 : 0,
                      duration: _duration,
                      curve: _curve,
                      child: _buildTextFormField(
                          'Confirm Password', _cPasswordlController)),
                  // SizedBox(height: 8),
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
                          isRegister ? _register() : _login(context);
                          Provider.of<PageNotifier>(context, listen: false)
                              .goToOtherPage('WelcomLogin');
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    try {
      final UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _PasswordController.text);

      final User = result.user;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('로그인 성공'),
          duration: const Duration(seconds: 5)));



      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => WelcomeLogin()));
      Provider.of<PageNotifier>(context, listen: false).goToMain();
      // print(User);
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

  void _register() async {
    if (_PasswordController.text != _cPasswordlController.text) {
      final snacBar = SnackBar(content: Text('비밀번호가 일치하지 않습니다.'));
      ScaffoldMessenger.of(context).showSnackBar(snacBar);
      return;
    }

    try {
      final UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _PasswordController.text);

      Provider.of<PageNotifier>(context, listen: false).goToMain();
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
    bool _passwordInVisible = !_isEmailAddress;

    return TextFormField(
      obscureText: _passwordInVisible,
      cursorColor: Colors.black87,
      controller: ctlr,
      validator: (text) {
        if (ctlr != _cPasswordlController && (text == null || text.isEmpty)) {
          return '입력창이 비어있습니다.';
        }
        if (ctlr == _cPasswordlController &&
            isRegister &&
            (text == null || text.isEmpty)) {
          if (text == null || text.isEmpty) return "잘못된 비밀번호가 입력되었습니다.";
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
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
