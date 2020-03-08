import 'dart:convert';
import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:intl/intl.dart';

import '../api/keys.dart';
// import '../models/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/tweet.dart';
import '../models/user.dart';

User _authenticatedUser;

class ConnectedModel extends Model {
  // bool _isLoading = false;
  List<Tweet> feedList = [];
  final uri = ApiKeys.uri;
}

class UserModel extends ConnectedModel {
  User get authenticatedUser {
    return _authenticatedUser;
  }

  void setAuthenticatedUser(String userid) {}

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
        getAuthenticatedUser(res['userId'], res['token']);
      }
    }).catchError((error) {
      print("Fetch Authenticated User Error: ${error.toString()}");
      return;
    });
  }

  Future<Null> getAuthenticatedUser(String userId, String token) async {
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
        _authenticatedUser = user;
        // print(user.token);
        // print(uri + authenticatedUser.avatar);
        // print(authenticatedUser.token);

      }
    }).catchError((error) {
      print("Fetch Authenticated User Error: ${error.toString()}");
      return;
    });
  }
}

class TweetModel extends ConnectedModel {
  List<Tweet> get feedTweetsList {
    return List.from(feedList);
  }

  Future<Null> fetchTweets() async {
    return await http
        .get(uri + 'api/tweets')
        .then<Null>((http.Response response) {
      if (response.statusCode == 200) {
        // print('11111111111111');
        final List<Tweet> fetchedTweetList = [];
        final Map<String, dynamic> entryListData =
            json.decode(response.body)['response'];
        if (entryListData['count'] == 0) {
          return;
        }
        entryListData['tweets'].forEach((dynamic entryData) {
          final Tweet entry = Tweet(
            tweetId: entryData['_id'],
            name: entryData['name'],
            userId: entryData['user'],
            tweetText: entryData['text'],
            mentions: entryData['mentions'],
            hashtags: entryData['hashtags'],
            username: entryData['username'],
            avatar: entryData['avatar'],
            date: entryData['date'],
            likes: entryData['likes'],
            retweets: entryData['retweets'],
            replyingTo: entryData['replyingTo'],
            comments: entryData['comments'],
          );
          fetchedTweetList.add(entry);
        });
        feedList = fetchedTweetList;
      } else {
        print(
            "Fetch Tweets Error: ${json.decode(response.body)["error"].toString()}");
      }
    }).catchError((error) {
      print("Fetch Tweets Error: ${error.toString()}");
      return;
    });
  }
}
