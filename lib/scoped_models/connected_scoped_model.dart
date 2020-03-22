// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:intl/intl.dart';

import '../api/keys.dart';
import 'dart:io';
// import '../models/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/tweet.dart';
// import '../models/user.dart';

class ConnectedModel extends Model {
  List<Tweet> feedList = [];
  final uri = ApiKeys.uri;
  bool isLoading = false;
  File file = null;
}
