import 'package:flutter/material.dart';
import 'package:twitter_clone/helpers/dimensions.dart';

import 'package:twitter_clone/helpers/dummy_user.dart';

class Profile_Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Profile_Screen_State();
  }
}

class _Profile_Screen_State extends State<Profile_Screen> {
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
                    onPressed: null,
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
                          du.name,
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
                          du.username,
                          style: TextStyle(
                              fontSize: getDeviceHeight(context) * 0.022,
                              fontWeight: FontWeight.w300),
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
                        Text(
                          du.bio,
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
                        Icon(Icons.cake),
                        Text(
                          ' Born ' + du.dateOfBirth,
                          style: TextStyle(
                              fontSize: getDeviceHeight(context) * 0.022,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.calendar_today),
                        Text(
                          ' Joined ' + du.dateOfJoining,
                          style: TextStyle(
                              fontSize: getDeviceHeight(context) * 0.022,
                              fontWeight: FontWeight.w300),
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
                          du.followingsno.toString(),
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
                          du.followersno.toString(),
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
                  IconButton(icon: Icon(Icons.list), onPressed: () => {}),
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
                      backgroundImage: AssetImage(du.avatar),
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
                    onPressed: null,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.add),
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
