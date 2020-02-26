import 'package:flutter/material.dart';
import 'dart:async';

import '../helpers/dimensions.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Center(
          child: Container(
            height: getDeviceHeight(context) * 0.30,
            width: getDeviceWidth(context) * 0.30,
            child: Image.asset('assets/icon.png'),
          ),
        ),
      ),
    );
  }
}
