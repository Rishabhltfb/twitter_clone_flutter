import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import '../models/user.dart';
import './connected_scoped_model.dart';

class UserModel extends ConnectedModel {
  User get getAuthenticatedUser {
    return authenticatedUser;
  }

  // void setAuthenticatedUser(String userid) {}

  Future<Null> login() async {
    Map<String, dynamic> req = {
      'email': 'rjhacker0403@gmail.com',
      'password': '12345'
    };
    return await http.post('${uri}api/users/login',
        body: json.encode(req),
        headers: {
          'Content-Type': 'application/json'
        }).then<Null>((http.Response response) {
      if (response.statusCode == 200) {
        final Map<String, dynamic> res = json.decode(response.body);
        setAuthenticatedUser(res['userId'], res['token']);
      }
    }).catchError((error) {
      print("Fetch Authenticated User Error: ${error.toString()}");
      return;
    });
  }

  Future<Null> setAuthenticatedUser(String userId, String token) async {
    return await http
        .get(
      '${uri}api/users/$userId',
    )
        .then<Null>((http.Response response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body)['user'];
        // print(responseData);
        User user = new User(
            userId: responseData['_id'],
            token: token,
            avatar: responseData['avatar'],
            bio: responseData['bio'],
            coverPic: responseData['coverPic'],
            dateOfBirth: responseData['dateOfJoining'],
            dateOfJoining: responseData['dateOfJoining'],
            email: responseData['email'],
            followers: responseData['followers'],
            followings: responseData['followings'],
            location: '',
            name: responseData['name'],
            phone: '',
            username: responseData['username']);
        authenticatedUser = user;
      }
    }).catchError((error) {
      print("Fetch Authenticated User Error: ${error.toString()}");
      return;
    });
  }
}
