import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

import '../helpers/dimensions.dart';
import '../helpers/dummy_user.dart';
import '../api/keys.dart';
import '../scoped_models/main_scoped_model.dart';
import '../helpers/my_flutter_app_icons.dart';

class TweetContent extends StatefulWidget {
  final int index;
  final MainModel model;
  TweetContent(this.index, this.model);

  @override
  State<StatefulWidget> createState() {
    return _TweetContentState(index, model);
  }
}

class _TweetContentState extends State<TweetContent> {
  final MainModel model;
  final int index;

  _TweetContentState(this.index, this.model);
  final DummyTweet dt = DummyTweet();
  final uri = ApiKeys.uri;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: getDeviceWidth(context) * 0.07),
              Icon(
                Icons.favorite,
                color: Colors.grey,
                size: 12,
              ),
              Text(
                dt.optionalLine,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ), // Row for optional text like liked and retweeted
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getDeviceWidth(context) * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: ProgressiveImage.assetNetwork(
                          placeholder: 'assets/avatar.png', // gifs can be used
                          thumbnail: uri +
                              model.parseImage(
                                  model.getAuthenticatedUser.avatar),
                          image: uri +
                              model.parseImage(
                                  model.getAuthenticatedUser.avatar),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            model.feedTweetsList[index].name,
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "@" + model.feedTweetsList[index].username,
                            style: TextStyle(fontWeight: FontWeight.w300),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            model.feedTweetsList[index].date,
                            style: TextStyle(fontWeight: FontWeight.w300),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getDeviceHeight(context) * 0.01),
                    Text(
                      model.feedTweetsList[index].tweetText,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(height: 10),
                    Container(
                      // color: Colors.yellow,
                      height: getDeviceHeight(context) * 0.2,
                      width: getDeviceWidth(context) * 0.7,
                      child: Image(
                        image: AssetImage('assets/wallpaper.jpg'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      MyFlutterApp.comment,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onPressed: null,
                  ),
                  Text(model.feedTweetsList[index].comments.length.toString())
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      MyFlutterApp.retweet,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onPressed: null,
                  ),
                  Text(model.feedTweetsList[index].retweets.length.toString())
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onPressed: null,
                  ),
                  Text(model.feedTweetsList[index].likes.length.toString())
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.share,
                  size: 17,
                  color: Colors.grey,
                ),
                onPressed: null,
              ),
            ],
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
