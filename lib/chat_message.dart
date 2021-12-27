import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget{
  final String txt;
  final Animation<double> animation;

  const ChatMessage(
    this.txt, {
    required this.animation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1.0,
          child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.amberAccent,
              child: Text('N'),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('ID'), Text(txt)],
              ),
            )
          ],
        ),
      )
    );
  }
}