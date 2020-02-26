import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scout',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "PermanentMarker-Regular"),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.favorite),
              onPressed: () {
                Navigator.pushNamed(context, '/err');
              },
            )
          ],
        ),
      ),
    );
  }
}
