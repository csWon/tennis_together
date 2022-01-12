import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_together/auth_page.dart';
import 'package:tennis_together/chatting.dart';
import 'package:tennis_together/provider/login_notifier.dart';
import 'package:tennis_together/provider/page_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_together/map.dart';
import 'package:tennis_together/MySchedule.dart';
import 'package:tennis_together/matchList.dart';
import 'package:tennis_together/styles.dart';
import 'login_profile_switch.dart';

class MyHomePage extends StatefulWidget {
  static const String pageName = 'MyHomePage';

  String get _pageName => pageName;

  // final String title;
  // String get pageName => pageName;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    MatchList(),
    Map(),
    MySchedule(),
    LoginProfileSwitch(),
    Chatting(),
  ];

  @override
  Widget build(BuildContext context) {
    print('_MyHomePageState_build');

    return Consumer2<LoginNotifier, PageNotifier>(
        builder: (context, LoginNotifier, PageNotifier, child) {
      return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   title: Text('Tennis Together'),
          //   // actions: [
          //   //   IconButton(
          //   //       icon: Icon(Icons.logout),
          //   //       onPressed: () {
          //   //         print('login check');
          //   //         Provider.of<PageNotifier>(context, listen: false)
          //   //             .goToOtherPage(AuthPage.pageName);
          //   //       })
          //   // ]
          // ),
          body: _children[PageNotifier.selectedIndex],
          // ChangeNotifierProvider(
          //     create: (_) => PageNotifier(),
          //     child:
          //     Navigator(
          //   pages: [
          //     MaterialPage(
          //         key: const ValueKey(MatchList.pageName), child: MatchList()),
          //     if (PageNotifier.currentPage == MatchList.pageName ||
          //         PageNotifier.currentIndex == 0)
          //       MatchListPage(),
          //     if (PageNotifier.currentPage == MySchedule.pageName ||
          //         PageNotifier.currentIndex == 1)
          //       MySchedulePage(),
          //     if (PageNotifier.currentPage == Map.pageName ||
          //         PageNotifier.currentIndex == 2)
          //       MapPage(),
          //     if (PageNotifier.currentPage == AuthPage.pageName ||
          //         PageNotifier.currentIndex == 3)
          //       LoginProfileSwitchPage(),
          //   ],
          //   onPopPage: (route, result) {
          //     if (!route.didPop(result)) {
          //       return false;
          //     }
          //     return true;
          //   },
          // ),
          // ), // MultiProvider(
          //           providers: [
          //             ChangeNotifierProvider(create: (_) => PageNotifier()),
          //           ],
          //           child: _children[_selectedIndex],
          //       ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.backgroundFadedColor,
            selectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(color: Colors.black87),
            unselectedItemColor: Colors.black87.withOpacity(.60),
            unselectedLabelStyle:
                TextStyle(color: Colors.black87.withOpacity(.60)),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            // currentIndex: provider.currentIndex,
            currentIndex: _selectedIndex,
            //현재 선택된 Index
            onTap: (int index) {
              // provider.goToOtherPageByIndex(index);
              // setState(() {
              //   _selectedIndex = index;
              // });
              PageNotifier.goToOtherPageByIndex(index);
              // Provider.of<PageNotifier>(context, listen: false)
              //     .goToOtherPageByIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                label: Text('모임 리스트').data,
                icon: Icon(Icons.list, color: AppColors.mainColor),
              ),
              BottomNavigationBarItem(
                label: Text('지도').data,
                icon: Icon(Icons.map, color: AppColors.mainColor),
              ),
              BottomNavigationBarItem(
                label: Text('내 일정').data,
                icon: Icon(Icons.schedule, color: AppColors.mainColor),
              ),
              BottomNavigationBarItem(
                label:
                    LoginNotifier.isLogin ? Text('프로필').data : Text('로그인').data,
                //LoginProfileSwitch().GetStr(),
                icon: Icon(Icons.person, color: AppColors.mainColor),
              ),
            ],
          )

          //BottomNavigationBar(
          //   type: BottomNavigationBarType.fixed,
          //   backgroundColor: Colors.grey,
          //   selectedItemColor: Colors.white,
          //   unselectedItemColor: Colors.white.withOpacity(.60),
          //   selectedFontSize: 14,
          //   unselectedFontSize: 14,
          //   currentIndex: _selectedIndex,
          //   //현재 선택된 Index
          //   onTap: (int index) {
          //     setState(() {
          //       _selectedIndex = index;
          //     });
          //   },
          //   items: [
          //     BottomNavigationBarItem(
          //       label: Text('모임 리스트').data,
          //       icon: Icon(Icons.list),
          //     ),
          //     BottomNavigationBarItem(
          //       label: Text('지도').data,
          //       icon: Icon(Icons.map),
          //     ),
          //     BottomNavigationBarItem(
          //       label: Text('내 일정').data,
          //       icon: Icon(Icons.schedule),
          //     ),
          //     BottomNavigationBarItem(
          //       label: LoginProfileSwitch().GetStr(),//_isLogin.value ? Text('프로필').data : Text('로그인').data,
          //       icon: Icon(Icons.person),
          //     ),
          //   ],
          // ),
          );
    });

    // r   ]));
  }

  Widget Test() {
    int a = 1;
    return LoginProfileSwitch();
  }
}
