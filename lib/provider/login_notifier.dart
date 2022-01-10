import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gender_picker/source/enums.dart';

class LoginNotifier with ChangeNotifier{
  bool _isLogin = false;
  String _nickName = '';
  int _ballPower = 0;
  Gender _gender = Gender.Female;
  String _location = '강남구';

  bool get isLogin => _isLogin;
  String get nickName => _nickName;
  Gender get gender => _gender;
  int get ballPower => _ballPower;
  String get location => _location;


  bool CheckLogin(){
    _isLogin = FirebaseAuth.instance.currentUser == null ? false : true;
    // notifyListeners();
    return _isLogin;
  }

  void SetNickName(String string){
    _nickName = string;
  }

  void SetGender(Gender gender){
    _gender = gender;
    print('SetGender');
  }

  void SetBallPower(int bp){
    _ballPower = bp;
  }


}