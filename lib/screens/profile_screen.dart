import 'package:flutter/material.dart';
import 'package:twitter_clone/helpers/dimensions.dart';
import 'package:twitter_clone/helpers/my_flutter_app_icons.dart';
import '../api/keys.dart';

import '../scoped_models/main_scoped_model.dart';
import '../widgets/tweets.dart';

class Profile_Screen extends StatefulWidget {
  final MainModel model;

  Profile_Screen(this.model);

  @override
  State<StatefulWidget> createState() {
    return _Profile_Screen_State(model);
  }
}

class _Profile_Screen_State extends State<Profile_Screen>
    with TickerProviderStateMixin {
  final MainModel model;
  final uri = ApiKeys.uri;

  _Profile_Screen_State(this.model);

  TabController _tabController;
  List<Tab> tabList = List();
  @override
  void initState() {
    tabList.add(new Tab(
      text: 'Overview',
    ));
    tabList.add(new Tab(
      text: 'Workouts',
    ));
    tabList.add(new Tab(
      text: 'Latest',
    ));
    tabList.add(new Tab(
      text: 'Newest',
    ));
    _tabController =
        new TabController(vsync: this, length: tabList.length, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          model.getAuthenticatedUser.name,
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
                          "@" + model.getAuthenticatedUser.username,
                          style: TextStyle(
                              fontSize: getDeviceHeight(context) * 0.022,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    model.getAuthenticatedUser.bio == ''
                        ? Container()
                        : SizedBox(
                            height: 10,
                          ),
                    model.getAuthenticatedUser.bio == ''
                        ? Container()
                        : Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                model.getAuthenticatedUser.bio,
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
                        // Expanded(
                        //   flex: 1,
                        //   child: Text(
                        //     ' Born ' + model.getAuthenticatedUser.dateOfBirth,
                        //     style: TextStyle(
                        //         fontSize: getDeviceHeight(context) * 0.022,
                        //         fontWeight: FontWeight.w300),
                        //   ),
                        // ),
                        // SizedBox(width: 10),
                        Icon(
                          Icons.calendar_today,
                          size: getDeviceHeight(context) * 0.022,
                          color: Colors.grey,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            ' Joined ' +
                                model.getAuthenticatedUser.dateOfJoining,
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
                          model.getAuthenticatedUser.followings.length == null
                              ? "0"
                              : model.getAuthenticatedUser.followings.length
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
                          model.getAuthenticatedUser.followers.length == null
                              ? "0"
                              : model.getAuthenticatedUser.followers.length
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
                    new Container(
                      child: new TabBar(
                        controller: _tabController,
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
                    ),
                    new Container(
                      height: getDeviceHeight(context) * 0.45,
                      child: new TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return TweetContent(index, model);
                            },
                            itemCount: model.feedTweetsList.length,
                          ),
                          ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return TweetContent(index, model);
                            },
                            itemCount: model.feedTweetsList.length,
                          ),
                          Container(
                            color: Colors.blueGrey[100],
                            child: Center(
                              child: Text(
                                'You haven\'t Tweeted any photos or videos yet',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: getDeviceWidth(context) * 0.08,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return TweetContent(index, model);
                            },
                            itemCount: model.feedTweetsList.length,
                          ),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FadeInImage.assetNetwork(
                        height: getDeviceWidth(context) * 0.22,
                        fadeInCurve: Curves.easeIn,
                        placeholder: 'assets/avatar.png',
                        image: uri +
                            model.parseImage(model.getAuthenticatedUser.avatar),
                      ),
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
                    onPressed: () => print(model.authenticatedUser.token),
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
