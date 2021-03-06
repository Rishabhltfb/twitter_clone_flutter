import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:twitter_clone/helpers/dimensions.dart';
// import 'package:twitter_clone/helpers/dummy_user.dart';
import 'package:twitter_clone/helpers/my_flutter_app_icons.dart';
import 'dart:ui';

import '../scoped_models/main_scoped_model.dart';
import 'package:twitter_clone/widgets/drawer_list_item.dart';
import '../api/keys.dart';

class SideDrawer extends StatelessWidget {
  // final DummyUser du = DummyUser();
  final uri = ApiKeys.uri;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          width: getViewportWidth(context) * 0.85,
          child: Drawer(
            elevation: 5,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: getDeviceHeight(context) * 0.025,
                ),
                model.isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        height: getViewportHeight(context) * 0.275,
                        child: DrawerHeader(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/profile');
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: FadeInImage.assetNetwork(
                                    height: getDeviceHeight(context) * 0.08,
                                    fadeInCurve: Curves.easeIn,
                                    placeholder: 'assets/avatar.png',
                                    image: uri +
                                        model.parseImage(
                                            model.getAuthenticatedUser.avatar),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                model.authenticatedUser.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w700,
                                    fontSize:
                                        getViewportHeight(context) * 0.025),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '@' + model.authenticatedUser.username,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w300,
                                    fontSize:
                                        getViewportHeight(context) * 0.022),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Text(
                                    model.authenticatedUser.followings.length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "  Following",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(width: 15.0),
                                  Text(
                                    model.authenticatedUser.followers.length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "  Followers",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                DrawerListItem(
                  tileIcon: Icons.perm_identity,
                  tileName: "Profile",
                  routeName: "/profile",
                ),
                SizedBox(
                  height: 2,
                ),
                DrawerListItem(
                  tileIcon: MyFlutterApp.list,
                  tileName: "Lists",
                  routeName: "/error",
                ),
                SizedBox(
                  height: 2,
                ),
                DrawerListItem(
                  tileIcon: Icons.chat,
                  tileName: "Topics",
                  routeName: "/error",
                ),
                SizedBox(
                  height: 2,
                ),
                DrawerListItem(
                  tileIcon: Icons.bookmark_border,
                  tileName: "Bookmarks",
                  routeName: "/error",
                ),
                SizedBox(
                  height: 2,
                ),
                DrawerListItem(
                  tileIcon: MyFlutterApp.thunder,
                  tileName: "Moments",
                  routeName: "/error",
                ),
                SizedBox(
                  height: 2,
                ),
                Divider(thickness: 1),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/error');
                  },
                  splashColor: Colors.grey,
                  child: Container(
                    alignment: Alignment.center,
                    height: getViewportHeight(context) * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: getViewportWidth(context) * 0.014,
                        ),
                        Text(
                          'Settings and privacy',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/error');
                  },
                  splashColor: Colors.grey,
                  child: Container(
                    alignment: Alignment.center,
                    height: getViewportHeight(context) * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: getViewportWidth(context) * 0.014,
                        ),
                        Text(
                          'Help Center',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: getDeviceHeight(context) * 0.07),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        MyFlutterApp.lightbulb,
                        color: Theme.of(context).primaryColor,
                      ),
                      Icon(
                        MyFlutterApp.qrcode_1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
