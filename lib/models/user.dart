import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String username;
  final String email;
  final String phone;
  final String avatar;
  final String coverPic;
  final String dateOfJoining;
  final String dateOfBirth;
  final int noOfTweets;
  final int followersno;
  final int followingsno;
  final String bio;
  final String location;
  User({
    @required this.name,
    @required this.username,
    @required this.email,
    @required this.phone,
    @required this.avatar,
    @required this.coverPic,
    @required this.dateOfJoining,
    @required this.dateOfBirth,
    @required this.noOfTweets,
    @required this.followersno,
    @required this.followingsno,
    @required this.bio,
    @required this.location,
  });
}
