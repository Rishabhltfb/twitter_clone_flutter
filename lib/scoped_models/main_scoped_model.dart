import 'package:scoped_model/scoped_model.dart';

import './connected_scoped_model.dart';
import './user_model.dart';
import './tweet_model.dart';

class MainModel extends Model with ConnectedModel, UserModel, TweetModel {}
