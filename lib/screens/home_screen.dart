import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/scheduler.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main_scoped_model.dart';
import 'package:twitter_clone/helpers/my_flutter_app_icons.dart';
import 'package:twitter_clone/widgets/side_drawer.dart';
import 'package:twitter_clone/helpers/dimensions.dart';
import 'package:twitter_clone/helpers/dummy_user.dart';
import '../api/keys.dart';
import '../widgets/tweets.dart';

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
  final DummyTweet dt = DummyTweet();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    model.fetchTweets();
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

  Widget body() {
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return TweetContent(index, model);
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
                  onPressed: () => Navigator.pushNamed(context, '/tweet'),
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
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
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
                        model.isLoading
                            ? CircularProgressIndicator()
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: FadeInImage.assetNetwork(
                                  height: getDeviceHeight(context) * 0.05,
                                  fadeInCurve: Curves.easeIn,
                                  placeholder: 'assets/avatar.png',
                                  image: uri +
                                      model.parseImage(
                                          model.getAuthenticatedUser.avatar),
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
                  icon: new Icon(
                    Icons.notifications_none,
                  ),
                  title: new Text('', style: TextStyle(fontSize: 0)),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    MyFlutterApp.mail,
                    size: getViewportHeight(context) * 0.035,
                  ),
                  title: new Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
                ),
              ],
            ),
          ),
          body: model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : body(),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    super.dispose();
  }
}
