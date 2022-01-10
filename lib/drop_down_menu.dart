import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = '복식';
  String test = 'test';

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      DropdownButton<String>(
        value: test,
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54,),
        elevation: 16,
        style: const TextStyle(color: Colors.black87),
        // underline: Container(
        //   height: 2,
        //   color: Colors.deepPurpleAccent,
        // ),
        onChanged: (String? test) {
          setState(() {
            test = test!;
          });
        },
        items: <String>['sss', 'kk']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54,),
      elevation: 16,
      style: const TextStyle(color: Colors.black87),
      // underline: Container(
      //   height: 2,
      //   color: Colors.deepPurpleAccent,
      // ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['복식', '단식']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    )
    ]);
  }
}