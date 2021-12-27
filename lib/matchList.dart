import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MatchListPage extends StatefulWidget {
  final String title;
  MatchListPage({this.title = 'Demo'});
  @override
  _MatchListPageState createState() => _MatchListPageState();
}

class _MatchListPageState extends State<MatchListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  buildCard(),
                  buildCard(),
                  buildCard(),
                  buildCard(),
                  buildCard(),
                  buildCard(),
                  buildCard(),
                ],
              )),
    ));
  }
}

Card buildCard() {
  var heading = '\$2300 per month';
  var subheading = '2 bed, 1 bath, 1300 sqft';
  var cardImage = NetworkImage(
      'https://source.unsplash.com/random/800x600?house');
  var supportingText =
      'Beautiful home to rent, recently refurbished with modern appliances...';
  return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(heading),
            subtitle: Text(subheading),
            // trailing: Icon(Icon.favorite_outline),
          ),
          // Container(
          //   height: 200.0,
          //   child: Ink.image(
          //     image: cardImage,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(supportingText),
          )
          // ButtonBar(
          //   children: [
          //     TextButton(
          //       child: const Text('CONTACT AGENT'),
          //       onPressed: () {/* ... */},
          //     ),
          //     TextButton(
          //       child: const Text('LEARN MORE'),
          //       onPressed: () {/* ... */},
          //     )
          //   ],
          // )
        ],
      ));
}