import 'package:tennis_together/auth_page.dart';
import 'package:tennis_together/provider/page_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_together/map.dart';
import 'package:tennis_together/MySchedule.dart';
import 'package:tennis_together/chatting.dart';
import 'package:tennis_together/matchList.dart';

class MyHomePage extends StatefulWidget {
  static const String pageName = 'MyHomePage';

  // final String title;
  // String get pageName => pageName;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    MatchListPage(),
    Map(),
    MySchedule(),
    Chatting()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tennis Together'), actions: [
        IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<PageNotifier>(context, listen: false)
                  .goToOtherPage(AuthPage.pageName);
            })
      ]),
      body: _children[_selectedIndex]
      // margin: EdgeInsets.all(20),`
      //
      // children: [
      //   Image.asset('bg_tennis.jpeg'),
      //   Icon(Icons.star)
      // ]
      ,

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
            label: Text('프로필').data,
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
