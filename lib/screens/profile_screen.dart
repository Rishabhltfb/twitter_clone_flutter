import 'package:flutter/material.dart';
import 'package:twitter_clone/helpers/dimensions.dart';
// import 'package:scoped_model/scoped_model.dart';
import 'package:twitter_clone/helpers/my_flutter_app_icons.dart';
// import 'package:twitter_clone/models/user.dart';
// import 'package:intl/intl.dart';
import '../api/keys.dart';

import '../scoped_models/main_scoped_model.dart';
import 'package:twitter_clone/helpers/dummy_user.dart';

class Profile_Screen extends StatefulWidget {
  final MainModel model;

  Profile_Screen(this.model);

  @override
  State<StatefulWidget> createState() {
    return _Profile_Screen_State(model);
  }
}

class _Profile_Screen_State extends State<Profile_Screen> {
  final MainModel model;
  final uri = ApiKeys.uri;

  _Profile_Screen_State(this.model);
  final DummyUser du = DummyUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                height: getDeviceHeight(context) * 0.2,
              ),
              SizedBox(height: 7.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    textColor: Colors.grey,
                    child: Text('Edit Profile'),
                    onPressed: () => Navigator.pushNamed(context, '/error'),
                  ),
                  SizedBox(width: 10.0)
                ],
              ),
              Container(
                // color: Colors.yellow,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          model.authenticatedUser.name,
                          style: TextStyle(
                              fontSize: getDeviceHeight(context) * 0.035,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "@" + model.authenticatedUser.username,
                          style: TextStyle(
                              fontSize: getDeviceHeight(context) * 0.022,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    model.authenticatedUser.bio == ''
                        ? Container()
                        : SizedBox(
                            height: 10,
                          ),
                    model.authenticatedUser.bio == ''
                        ? Container()
                        : Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                model.authenticatedUser.bio,
                                style: TextStyle(
                                  fontSize: getDeviceHeight(context) * 0.022,
                                ),
                              )
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        // Icon(MyFlutterApp.balloon),
                        // Text(
                        //   ' Born ' + model.authenticatedUser.dateOfBirth,
                        //   style: TextStyle(
                        //       fontSize: getDeviceHeight(context) * 0.022,
                        //       fontWeight: FontWeight.w300),
                        // ),
                        // SizedBox(width: 10),
                        Icon(
                          Icons.calendar_today,
                          size: getDeviceHeight(context) * 0.022,
                          color: Colors.grey,
                        ),
                        Container(
                          child: Text(
                            ' Joined ' + model.authenticatedUser.dateOfJoining,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: getDeviceHeight(context) * 0.022,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          model.authenticatedUser.followings.length == null
                              ? "0"
                              : model.authenticatedUser.followings.length
                                  .toString(),
                          style: TextStyle(
                              fontSize: getDeviceHeight(context) * 0.022,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' Following',
                          style: TextStyle(
                              fontSize: getDeviceHeight(context) * 0.022,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          model.authenticatedUser.followers.length == null
                              ? "0"
                              : model.authenticatedUser.followers.length
                                  .toString(),
                          style: TextStyle(
                              fontSize: getDeviceHeight(context) * 0.022,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' Followers',
                          style: TextStyle(
                              fontSize: getDeviceHeight(context) * 0.022,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    SizedBox(
                      height: getDeviceHeight(context) * 0.025,
                    ),
                    DefaultTabController(
                      initialIndex: 0,
                      length: 4,
                      child: Column(
                        children: <Widget>[
                          TabBar(
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.blueGrey,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelPadding: EdgeInsets.symmetric(horizontal: 0.1),
                            tabs: <Widget>[
                              Tab(
                                text: 'Tweets',
                              ),
                              Tab(
                                text: 'Tweets & replies',
                              ),
                              Tab(
                                text: 'Media',
                              ),
                              Tab(
                                text: 'Likes',
                              ),
                            ],
                          ),
                          // TabBarView(
                          //   children: <Widget>[],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  IconButton(
                      icon: Icon(MyFlutterApp.points3),
                      onPressed: () => Navigator.pushNamed(context, '/error')),
                ],
              ),
              SizedBox(
                height: getDeviceHeight(context) * 0.05,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: getDeviceWidth(context) * 0.1,
                      backgroundImage: NetworkImage(du.avatar),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: getDeviceHeight(context) * 0.9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () => model.login(),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(MyFlutterApp.feather),
                  ),
                  SizedBox(width: 15)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
