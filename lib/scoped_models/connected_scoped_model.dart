import 'dart:convert';
import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:intl/intl.dart';

import '../api/keys.dart';
// import '../models/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ConnectedModel extends Model {
  // bool _isLoading = false;

  User authenticatedUser;
}

class UserModel extends ConnectedModel {
  final uri = ApiKeys.uri;

  void setAuthenticatedUser(String userid) {}

  Future<Null> login() async {
    Map<String, dynamic> req = {'email': 'yoyo@gmail.com', 'password': '12345'};
    return await http.post('${uri}/api/users/login',
        body: json.encode(req),
        headers: {
          'Content-Type': 'application/json'
        }).then<Null>((http.Response response) {
      if (response.statusCode == 200) {
        final Map<String, dynamic> res = json.decode(response.body);
        getAuthenticatedUser(res['userId']);
      }
    }).catchError((error) {
      print("Fetch Authenticated User Error: ${error.toString()}");
      return;
    });
  }

  Future<Null> getAuthenticatedUser(String userId) async {
    return await http
        .get(
      '${uri}/api/users/$userId',
    )
        .then<Null>((http.Response response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body)['user'];
        print(responseData);
        User user = new User(
            avatar: responseData['avatar'],
            bio: responseData['bio'],
            coverPic: responseData['coverPic'],
            dateOfBirth: 'October 3, 1999',
            dateOfJoining: responseData['dateOfJoining'],
            email: responseData['email'],
            followersno: responseData['noOfFollowers'],
            followingsno: responseData['noOfFollowings'],
            location: '',
            name: responseData['name'],
            noOfTweets: responseData['noOfTweets'],
            phone: '',
            username: responseData['username']);
        authenticatedUser = user;
        print(user.email);
        print(authenticatedUser.name);
      }
    }).catchError((error) {
      print("Fetch Authenticated User Error: ${error.toString()}");
      return;
    });
  }
}
