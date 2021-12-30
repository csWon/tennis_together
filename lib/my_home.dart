import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_together/auth_page.dart';
import 'package:tennis_together/provider/page_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_together/map.dart';
import 'package:tennis_together/MySchedule.dart';
import 'package:tennis_together/matchList.dart';

import 'login_profile_switch.dart';

class MyHomePage extends StatefulWidget {
  static const String pageName = 'MyHomePage';

  // final String title;
  // String get pageName => pageName;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<bool> _isLogin =
      ValueNotifier<bool>(false); // ValueNotifier 변수 선언

  int _selectedIndex = 0;

  // bool isLogin = FirebaseAuth.instance.currentUser == null ? false : true;

  final List<Widget> _children = [
    MatchListPage(),
    Map(),
    MySchedule(),
    LoginProfileSwitch(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Tennis Together'),
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.logout),
        //       onPressed: () {
        //         print('login check');
        //         Provider.of<PageNotifier>(context, listen: false)
        //             .goToOtherPage(AuthPage.pageName);
        //       })
        // ]
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        //현재 선택된 Index
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            // FirebaseAuth auth = FirebaseAuth.instance;
            // isLogin = auth.currentUser == null ? false : true;
            // print(auth.currentUser);
            // print(Text('islogin_' + isLogin.toString()));
          });
        },
        items: [
          BottomNavigationBarItem(
            label: Text('모임 리스트').data,
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            label: Text('지도').data,
            icon: Icon(Icons.map),
          ),
          BottomNavigationBarItem(
            label: Text('내 일정').data,
            icon: Icon(Icons.schedule),
          ),
          BottomNavigationBarItem(
            label: _isLogin.value ? Text('프로필').data : Text('로그인').data,
            icon: Icon(Icons.person),
          ),
        ],
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: SizedBox(
      //     height: 70,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         Icon(Icons.accessibility),
      //         Icon(Icons.access_alarms),
      //         Icon(Icons.accessibility),
      //         Icon(Icons.accessibility),
      //       ],
      //     ),
      //   )
      // ),
    );

    // return Scaffold(
    //     appBar: AppBar(title: Text('Tennis Together'), actions: [
    //       IconButton(
    //           icon: Icon(Icons.logout),
    //           onPressed: () {
    //             Provider.of<PageNotifier>(context, listen: false)
    //                 .goToOtherPage(AuthPage.pageName);
    //           })
    //     ]));
  }
}

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;
  // bool
  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}