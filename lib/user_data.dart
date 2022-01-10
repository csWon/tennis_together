import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gender_picker/source/enums.dart';

class UserData {
  final String? uid;
  final String? nickName;
  final double? ntrp;
  final String? address;
  final String? gender;
  final String? selfIntro;

  String? get _uid => uid;
  String? get _nickName => nickName;
  String? get _selfIntro => selfIntro;
  String? get _address => address;
  String? get _gender => gender;
  double? get _ntrp => ntrp;

  UserData(
      {required this.uid,
      required this.nickName,
      required this.ntrp,
      required this.address,
      required this.gender,
      required this.selfIntro});
}

class ServiceData{
  String uid;
  ServiceData(this.uid);

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      nickName: snapshot['nickName'],
      ntrp: snapshot['ntrp'],
      address: snapshot['location'],
      gender: snapshot['gender'],
      selfIntro: snapshot['selfIntroduction'],
    );
  }

  Stream<UserData> get getUserData {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}