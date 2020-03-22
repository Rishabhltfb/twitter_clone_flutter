import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/helpers/dimensions.dart';
import 'dart:io';

import '../scoped_models/main_scoped_model.dart';

class TestScreen extends StatefulWidget {
  final MainModel model;
  TestScreen(this.model);
  @override
  _TestScreenState createState() => _TestScreenState(model);
}

class _TestScreenState extends State<TestScreen> {
  final MainModel model;
  String id;
  _TestScreenState(this.model);
  File _image;

  Future getImage(BuildContext context, ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source, maxWidth: 400);

    setState(() {
      _image = image;
      model.setImage(image);
      // model.imageUpload(id, _image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.yellow,
        height: getDeviceHeight(context) * 0.4,
        width: getDeviceWidth(context),
        child: Column(
          children: <Widget>[
            _image == null
                ? Text('No media selected.')
                : Container(
                    // color: Colors.yellow,
                    height: 200,
                    width: 300,
                    child: Image.file(_image),
                  ),
            SizedBox(height: getDeviceHeight(context) * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    getImage(context, ImageSource.gallery);
                  },
                  tooltip: 'Pick Image from gallery',
                  icon: Icon(
                    Icons.image,
                    size: 50,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  onPressed: () {
                    getImage(context, ImageSource.camera);
                  },
                  tooltip: 'Click a new image',
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 50,
                  ),
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
