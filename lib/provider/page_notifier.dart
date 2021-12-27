import 'package:tennis_together/auth_page.dart';
import 'package:tennis_together/my_home.dart';
import 'package:flutter/cupertino.dart';

class PageNotifier extends ChangeNotifier{
  String _currentPage = MyHomePage.pageName;
  String get currentPage =>_currentPage;

  void goToMain(){
    _currentPage = MyHomePage.pageName;
    notifyListeners();
  }
  void goToOtherPage(String name){
    _currentPage = name;
    notifyListeners();
  }
}