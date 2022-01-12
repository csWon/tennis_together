import 'package:tennis_together/auth_page.dart';
import 'package:tennis_together/my_home.dart';
import 'package:tennis_together/welcome_login.dart';
import 'package:flutter/cupertino.dart';

class PageNotifier extends ChangeNotifier{
  bool usingIntFlag = true;
  String _selectedPage = MyHomePage.pageName;
  int _selectedIndex = 0;

  String get selectedPage =>_selectedPage;
  int get selectedIndex => _selectedIndex;

  bool refreshThisPage = false;

  void goToMain(){
    _selectedPage = MyHomePage.pageName;
    usingIntFlag = false;
    notifyListeners();
  }
  void goToOtherPage(String name){
    print('before_$_selectedPage');
    _selectedPage = name;
    print('after_$_selectedPage');
    usingIntFlag = false;
    notifyListeners();
  }
  void goToOtherPageByIndex(int i){
    // if(i==0){
    //   _selectedPage = 'MySchedulePage';
    // }

    usingIntFlag = true;
    print(i);
    print('index_$_selectedPage');
    _selectedIndex = i;
    notifyListeners();
  }

  void refreshPage(){
    print(refreshThisPage);
    refreshThisPage = !refreshThisPage;
    print(refreshThisPage);
    // _selectedIndex = 1;
    notifyListeners();
  }
}