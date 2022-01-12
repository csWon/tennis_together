import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_together/forget_pw.dart';
import 'package:tennis_together/login_profile_switch.dart';
import 'package:tennis_together/provider/filter_notifier.dart';
import 'package:tennis_together/provider/login_notifier.dart';

import 'package:tennis_together/provider/page_notifier.dart';
import 'package:tennis_together/my_home.dart';
import 'package:tennis_together/auth_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  // runApp(
  //     MultiProvider(
  //         providers: [
  //           ChangeNotifierProvider(create: (_) => LoginNotifier()),
  //         ],
  //         child: MaterialApp(home:const MyApp())
  //     ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<LoginNotifier>(
    //   create: (_) => LoginNotifier(),
    //   child: MaterialApp(
    //       home:MyHomePage()),
    //   // builder: (BuildContext context) => LoginNotifier(),
    // );
    //1111
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PageNotifier()),
      ChangeNotifierProvider(create: (_) => LoginNotifier()),
      ChangeNotifierProvider(create: (_) => FilterNotifier()),
    ], child: MaterialApp(home: MyHomePage()));

    // return Scaffold(body: MyHomePage());
  }
}

//
// return MultiProvider(
// providers: [ChangeNotifierProvider(create: (_) => PageNotifier()),
// ChangeNotifierProvider(create: (_) => LoginNotifier())],
// child: MaterialApp(
// title: 'demo',
// home: Consumer<PageNotifier>(builder: (context, pageNotifier, child) {
// return Navigator(
// pages: [
// MaterialPage(
// key: const ValueKey(MyHomePage.pageName),
// child: MyHomePage()),
// if (pageNotifier.currentPage == AuthPage.pageName) AuthPage(),
// ],
// onPopPage: (route, result) {
// if (!route.didPop(result)) {
// return false;
// }
// return true;
// },
// );
// })),
// );
