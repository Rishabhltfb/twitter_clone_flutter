import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:twitter_clone/widgets/side_drawer.dart';
import 'package:twitter_clone/helpers/dimensions.dart';

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
  bool _show = true;
  double _bottomBarOffset = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    myScroll();
  }

  void showBottomBar() {
    setState(() {
      _show = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _show = false;
    });
  }

  void myScroll() async {
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
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
              leading: Container(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/avatar.png'),
                  radius: 10.0,
                ),
              ),
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
        height: getDeviceHeight(context) * 0.08,
        width: MediaQuery.of(context).size.width,
        child: _show
            ? BottomNavigationBar(
                currentIndex: 0, // this will be set when a new tab is tapped
                items: [
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.home),
                    title: new Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.search),
                    title: new Text('Search'),
                  ),
                  // BottomNavigationBarItem(
                  //   icon: new Icon(Icons.notifications_none),
                  //   title: new Text('Notification'),
                  // ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.mail), title: Text('Message'))
                ],
              )
            : Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
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
