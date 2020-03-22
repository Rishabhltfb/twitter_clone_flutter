import 'dart:io';
import 'package:flutter/material.dart';

import '../helpers/dimensions.dart';
import '../api/keys.dart';
import '../scoped_models/main_scoped_model.dart';
import './testing_screen.dart';

class ComposeTweet extends StatefulWidget {
  final MainModel model;

  ComposeTweet(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ComposeTweetState(model);
  }
}

class _ComposeTweetState extends State<ComposeTweet> {
  final MainModel model;
  final uri = ApiKeys.uri;

  _ComposeTweetState(this.model);
  final Map<String, dynamic> _formData = {
    'tweet': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _image;

  Widget _buildTweetTextField() {
    return Container(
      // height: getDeviceHeight(context) * 0.5,
      width: getDeviceWidth(context) * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColor,
        maxLength: 280,
        autofocus: true,
        style: TextStyle(
          fontSize: getViewportHeight(context) * 0.025,
          fontFamily: "Ubuntu",
        ),
        decoration: InputDecoration.collapsed(
          hintText: 'What\'s happening?',
        ),
        validator: (String value) {
          if (value.isEmpty || value.length > 281) {
            return 'Tweet is required and should be less than 280 character.';
          }
          return null;
        },
        onChanged: (String value) {
          _formData['tweet'] = value;
        },
        onSaved: (String value) {
          _formData['tweet'] = value;
        },
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    model
        .composeTweet(_formData['tweet'], model.getAuthenticatedUser.token)
        .then(
      (String tweetId) {
        if (tweetId != null) {
          TestScreen(model).createState();
          model.imageUpload(tweetId, model.getImage(), 'tweet');
          model.setImage(null);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Something went wrong!'),
                content: Text('Please try again!'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  )
                ],
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.clear),
          color: Theme.of(context).primaryColor,
        ),
        actions: <Widget>[
          FlatButton(
            padding: EdgeInsets.all(5),
            color: Theme.of(context).primaryColor,
            onPressed: () => _submitForm(),
            // splashColor: Colors.red,
            child: Text('Tweet'),
            textColor: Colors.white,
          ),
        ],
      ),
      body: Container(
        // color: Colors.red,
        height: getDeviceHeight(context),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              // height: getDeviceHeight(context) * 0.4,
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          ClipRRect(
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
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildTweetTextField(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getDeviceHeight(context) * 0.04),
            TestScreen(model),
          ],
        ),
      ),
    );
  }
}
