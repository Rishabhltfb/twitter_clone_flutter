import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
// import 'package:twitter_clone/helpers/my_flutter_app_icons.dart';
import 'package:twitter_clone/widgets/side_drawer.dart';
import 'package:twitter_clone/helpers/dimensions.dart';
import 'package:twitter_clone/helpers/dummy_user.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showAppbar = true; //this is to show app bar
  ScrollController _scrollBottomBarController =
      new ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;
  // bool _show = true;
  int bottom_navbar_index = 0;
  final DummyUser du = DummyUser();

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

  Widget containterContent() {
    return Container(
        height: getDeviceHeight(context) * 0.5,
        margin: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width - 100,
        child: Column(
          children: <Widget>[
            SizedBox(height: getDeviceHeight(context) * 0.24),
            Center(
              child: Center(
                child: Text(
                  'Tweets goes here',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: getDeviceHeight(context) * 0.2),
            Divider(
              thickness: 1,
            )
          ],
        ));
  }

  Widget body() {
    return ListView(
      controller: _scrollBottomBarController,
      children: <Widget>[
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
        containterContent(),
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
                      SizedBox(width: 10.0),
                      CircleAvatar(
                        radius: getDeviceHeight(context) * 0.025,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(du.avatar),
                      ),
                    ],
                  )),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
            )
          : PreferredSize(
              child: Container(),
              preferredSize: Size(0.0, 0.0),
            ),
      bottomNavigationBar: Container(
        height: getDeviceHeight(context) * 0.09,
        width: MediaQuery.of(context).size.width,
        child: BottomNavigationBar(
          currentIndex:
              bottom_navbar_index, // this will be set when a new tab is tapped
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text(''),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(
                Icons.search,
              ),
              title: new Text(''),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.notifications_none),
              title: new Text(''),
            ),
            // new BottomNavigationBarItem(
            //   icon: new Icon(Icons.mail),
            //   title: new Text('Message'),
            // ),
          ],
        ),
      ),
      body: body(),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    super.dispose();
  }
}
