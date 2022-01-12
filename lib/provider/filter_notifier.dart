import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';

class FilterNotifier with ChangeNotifier{

  RangeValues _currentRangeValues = const RangeValues(2.0, 3.5);
  String location='서울시 강남구';
  DateTimeRange? datetime;//DateTimeRange(start: DateTime.now(), end:  DateTime.now());

  RangeValues get currentRangeValues => _currentRangeValues;

  void SetNtrpRange(RangeValues rv){
    _currentRangeValues = rv;
    // notifyListeners();
  }



}