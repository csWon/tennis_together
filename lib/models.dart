import 'package:meta/meta.dart';
import 'package:tennis_together/user_data.dart';

/// {@template todo}
/// Model for a todo. Can contain an optional list of [items] for
/// additional sub-todos.
/// {@endtemplate}
class Todo {
  /// {@macro todo}
  Todo({
    required this.host,
      required this.starttime,
      required this.endtime,
      required this.memberCapacity,
      required this.location,
      required this.id,
      required this.description});

  /// The id of this todo.
  final String id;

  /// The description of this todo.
  final String description;
  final int memberCapacity;
  final UserData host;
  late List<UserData> guests;
  final DateTime starttime;
  final DateTime endtime;
  final String location;

  // condition
  // {ntrp, gender, }

  /// A list of [Item]s for sub-todos.
  late List<Item> items;
}

class UserData {
  UserData({
    required this.uid,
    required this.email,
    required this.nickName,
    required this.location,
    required this.selfIntro,
    required this.ntrp,
    required this.gender,
  });

  final String uid;
  final String email;
  final String nickName;
  final String location;
  final String selfIntro;
  final double ntrp;
  final String gender;
}

class ServiceUserData {
  late UserData _ud;

  ServiceUserData() {
    UpdateUserData();
  }

  UserData GetUserData() {
    return _ud;
  }

  void UpdateUserData() {}
}

/// {@template item}
/// An individual item model, used within a [Todo].
/// {@endtemplate}
class Item {
  /// {@macro item}
  Item({
    required this.id,
    this.description = '',
    this.completed = false,
  });

  /// The id of this item.
  final String id;

  /// Description of this item.
  final String description;

  /// Indicates if this item has been completed or not.
  bool completed;
}
