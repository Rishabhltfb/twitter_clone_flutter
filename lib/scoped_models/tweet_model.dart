import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/tweet.dart';
import './connected_scoped_model.dart';

class TweetModel extends ConnectedModel {
  List<Tweet> get feedTweetsList {
    return List.from(feedList);
  }

  Future<Null> fetchTweets() async {
    return await http
        .get(uri + 'api/tweets')
        .then<Null>((http.Response response) {
      if (response.statusCode == 200) {
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
