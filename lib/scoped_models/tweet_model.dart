// import 'dart:io';
import 'dart:convert';
import 'dart:async';
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import '../models/tweet.dart';
import './connected_scoped_model.dart';

class TweetModel extends ConnectedModel {
  List<Tweet> get feedTweetsList {
    return List.from(feedList);
  }

  Future<Null> fetchTweets() async {
    isLoading = true;
    notifyListeners();
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
        print('Inside fetchtweets : ' + isLoading.toString());
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        print(
            "Fetch Tweets Error: ${json.decode(response.body)["error"].toString()}");
      }
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      print("Fetch Tweets Error: ${error.toString()}");
      return;
    });
  }

  Future<String> composeTweet(String text, String token) async {
    isLoading = true;
    notifyListeners();
    print('Inside compose Tweet : ' + isLoading.toString());
    Map<String, dynamic> req = {
      'text': text,
      'mediaLinks': '',
    };
    try {
      http.Response response = await http
          .post('${uri}api/tweets/tweet', body: json.encode(req), headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      });
      Map<String, dynamic> res;
      if (response.statusCode == 200) {
        res = json.decode(response.body);
        print(res);

        isLoading = false;
        notifyListeners();
      }
      print(res['_id']);
      return res['_id'];
    } catch (error) {
      print("Error in composing tweet :  " + error.toString());
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  // Future<Null> imageUpload(String userId, File file) async {
  //   isLoading = true;
  //   notifyListeners();
  //   print('Inside imageUpload : ');
  //   try {
  //     var response =
  //         await http.patch('${uri}api/users/avatar/${userId}', body: );
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> res = json.decode(response.);
  //       print(res);
  //       isLoading = false;
  //       notifyListeners();
  //     }
  //   } catch (error) {
  //     print("Error in imageUpload:  " + error.toString());
  //     isLoading = false;
  //     notifyListeners();
  //     return;
  //   }
  // }

  // Future<Null> imageUpload(String userId, File image) async {
  //   isLoading = true;
  //   notifyListeners();
  //   print('Inside imageUpload : ');
  //   // Find the mime type of the selected file by looking at the header bytes of the file
  //   final mimeTypeData =
  //       lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
  //   // Intilize the multipart request
  //   final imageUploadRequest = http.MultipartRequest(
  //       'PATCH', Uri.parse('${uri}api/users/avatar/${userId}'));
  //   // Attach the file in the request
  //   final file = await http.MultipartFile.fromPath('avatar', image.path,
  //       contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  //   // Explicitly pass the extension of the image with request body
  //   // Since image_picker has some bugs due which it mixes up
  //   // image extension with file name like this filenamejpge
  //   // Which creates some problem at the server side to manage
  //   // or verify the file extension
  //   imageUploadRequest.fields['ext'] = mimeTypeData[1];
  //   imageUploadRequest.files.add(file);
  //   try {
  //     final streamedResponse = await imageUploadRequest.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //     print(response.statusCode);
  //     if (response.statusCode != 200 && response.statusCode != 201) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       print(responseData);
  //     }
  //   } catch (error) {
  //     print('Error in uploading image: ' + error);
  //     return null;
  //   }
  // }
}
