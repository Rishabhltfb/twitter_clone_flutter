import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String faculty_number;
  final String enrollment_number;
  final String gender;
  final int bitmoji_index;
  final String userId;

  User({
    @required this.name,
    @required this.faculty_number,
    @required this.enrollment_number,
    @required this.gender,
    @required this.bitmoji_index,
    @required this.userId,
  });
}
