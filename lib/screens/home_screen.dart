import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../scoped_models/main_scoped_model.dart';
import 'package:twitter_clone/helpers/my_flutter_app_icons.dart';
import 'package:twitter_clone/widgets/side_drawer.dart';
import 'package:twitter_clone/helpers/dimensions.dart';
import 'package:twitter_clone/helpers/dummy_user.dart';
import '../api/keys.dart';

class HomeScreen extends StatefulWidget {
  final MainModel model;

  HomeScreen(this.model);
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState(model);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final MainModel model;
  final uri = ApiKeys.uri;

  _HomeScreenState(this.model);
  bool _showAppbar = true; //this is to show app bar
  ScrollController _scrollBottomBarController =
      new ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;
  int bottom_navbar_index = 0;
  final DummyUser du = DummyUser();
  final DummyTweet dt = DummyTweet();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    myScroll();
  }

  void showBottomBar() {
    setState(() {
      _showAppbar = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _showAppbar = false;
    });
  }

  void myScroll() async {
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          showBottomBar();
        }
      }
    });
  }

  Widget containterContent(int index) {
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
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(dt.avatar),
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
                      size: 18,
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
                      size: 18,
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
                      size: 18,
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
                  size: 15,
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

  Widget body() {
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return containterContent(index);
          },
          itemCount: model.feedTweetsList.length,
          controller: _scrollBottomBarController,
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: isScrollingDown
                  ? getDeviceHeight(context) * 0.78
                  : getDeviceHeight(context) * 0.70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () => {},
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(MyFlutterApp.feather),
                ),
                SizedBox(width: 15)
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideDrawer(),
      appBar: _showAppbar
          ? AppBar(
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () => _scaffoldKey.currentState.openDrawer(),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: getDeviceHeight(context) * 0.025,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        du.avatar,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      MyFlutterApp.stars,
                      color: Theme.of(context).primaryColor,
                      size: getDeviceHeight(context) * 0.05,
                    ),
                    onPressed: null),
              ],
              title: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/home'),
                child: Image.asset(
                  'assets/icon.png',
                  color: Theme.of(context).primaryColor,
                  height: getDeviceHeight(context) * 0.06,
                ),
              ),
              centerTitle: true,
            )
          : PreferredSize(
              child: Container(),
              preferredSize: Size(0.0, 0.0),
            ),
      bottomNavigationBar: Container(
        height: getDeviceHeight(context) * 0.09,
        width: MediaQuery.of(context).size.width,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              bottom_navbar_index = index;
            });
          },
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Theme.of(context).primaryColor,
          iconSize: getDeviceHeight(context) * 0.04,
          currentIndex:
              bottom_navbar_index, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('', style: TextStyle(fontSize: 0)),
            ),
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.search,
              ),
              title: new Text('', style: TextStyle(fontSize: 0)),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.notifications_none),
              title: new Text('', style: TextStyle(fontSize: 0)),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text(
                '',
                style: TextStyle(fontSize: 0),
              ),
            ),
          ],
        ),
      ),
      body: body(),
    );
  }

  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    super.dispose();
  }
}
