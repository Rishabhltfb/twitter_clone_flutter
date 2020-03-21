import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
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
  _TestScreenState(this.model);
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      model.imageUpload('5e5955f3788635186080dcff', _image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Container(
                color: Colors.yellow,
                height: 200,
                width: 300,
                child: Image.file(_image),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
