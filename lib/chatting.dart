import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/logger.dart';
import 'package:tennis_together/chat_message.dart';

class Chatting extends StatefulWidget {
  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  // WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();

  GlobalKey<AnimatedListState> _animListKey = GlobalKey<AnimatedListState>();
  TextEditingController _textEditingController = TextEditingController();
  List<String> _chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ChatApp'),
        ),
        body: Column(
          children: [
            Expanded(
                child: AnimatedList(
              key: _animListKey,
              reverse: true,
              itemBuilder: _buildItem,
            )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(hintText: '메시지 입력'),
                    onSubmitted: _handleSumitted,
                  )),
                  SizedBox(
                    width: 8.0,
                  ),
                  FlatButton(
                    onPressed: () async {
                      print('before');
                      setData('hello Firebase');
                      print('enter');
                      _handleSumitted(_textEditingController.text);
                    },
                    child: Text('보내기'),
                    color: Colors.amberAccent,
                  )
                ],
              ),
            )
          ],
        ));

  }

  void setData(String txt) async {
    WidgetsFlutterBinding.ensureInitialized();
    print('setdata');

    await Firebase.initializeApp();
    final f = FirebaseFirestore.instance;
    await f
        .collection('profile')
        .doc('abc')
        .set({'abc??': txt});
  }

  Future<DocumentSnapshot> getData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("users")
        .doc("docID")
        .get();
  }

  Widget _buildItem(context, index, animation) {
    return ChatMessage(_chats[index], animation: animation);
  }

  void _handleSumitted(String text) {
    // Logger().d(text);
    _textEditingController.clear();
    _chats.insert(0, text);
    _animListKey.currentState?.insertItem(0);
  }
}
// TextButton.icon(
// style: TextButton.styleFrom(
// textStyle: TextStyle(color: Colors.blue),
// backgroundColor: Colors.white,
// shape:RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(24.0),
// ),
// ),
// onPressed: () => {},
// icon: Icon(Icons.send_rounded,),
// label: Text('Contact me',),
// ),