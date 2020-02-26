import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';
// import 'package:intl/intl.dart';

import '../api/keys.dart';
import '../models/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ConnectedModel extends Model {
  List<User> _userList = [];
  User _authenticatedUser;
  bool _isLoading = false;
}

class UserModel extends ConnectedModel {
  final key = ApiKeys.apiKey;
  // Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }

  List<User> get userList {
    return List.from(_userList);
  }

  void setAuthenticatedUser({String token, String userId}) {
    User currentUser = _userList.firstWhere((User user) {
      return user.userId == userId;
    });
    _authenticatedUser = currentUser;
    // _authenticatedUser.token = token;
    notifyListeners();
  }

  Future<Null> fetchUsers() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://scout-b7c59.firebaseio.com/users.json')
        .then<Null>((http.Response response) {
      final List<User> fetchedUserList = [];
      final Map<String, dynamic> userListData = json.decode(response.body);
      if (userListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      _isLoading = false;
      notifyListeners();

      userListData.forEach((String entryId, dynamic userData) {
        final User user = User(
          bitmoji_index: userData.bitmoji_index,
          enrollment_number: userData.enrollment_number,
          faculty_number: userData.faculty_number,
          gender: userData.gender,
          name: userData.name,
          userId: entryId,
        );
        fetchedUserList.add(user);
      });
      _userList = fetchedUserList;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<bool> addUserEntry({
    String email,
    String token,
    String name,
    String faculty_number,
    String enrollment_number,
    String gender,
    String bitmoji_index,
    String userId,
  }) async {
    final Map<String, dynamic> userEntry = {
      name: name,
      faculty_number: faculty_number,
      enrollment_number: enrollment_number,
      gender: gender,
      bitmoji_index: bitmoji_index,
      userId: userId
    };

    try {
      final http.Response response = await http.post(
          'https://scout-b7c59.firebaseio.com/users.json?auth=${token}',
          body: json.encode(userEntry));

      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      }
      final User newUser = User(
        name: name,
        faculty_number: faculty_number,
        enrollment_number: enrollment_number,
        gender: gender,
        bitmoji_index: 1,
        userId: userId,
      );
      _userList.add(newUser);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<Map<String, dynamic>> authenticate(
      String email, String password, String username,
      [AuthMode mode = AuthMode.Login]) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    _isLoading = true;
    notifyListeners();
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${key}',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${key}',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200 || response.statusCode == 201) {
        // await addUserEntry(email, json.decode(response.body)['localId'],
        //     json.decode(response.body)['idToken']);
      }
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData.containsKey('idToken')) {
      setAuthenticatedUser(
        token: responseData['idToken'],
        userId: responseData['localId'],
      );
    }
    if (mode == AuthMode.Login && !responseData.containsKey('error')) {
      // setAuthTimeout(int.parse(responseData['expiresIn']));
      _userSubject.add(true);
      final DateTime now = DateTime.now();
      final DateTime expiryTime =
          now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('refreshToken', responseData['refreshToken']);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    }
    if (responseData.containsKey('idToken')) {
      if (mode == AuthMode.Signup) {
        _isLoading = false;
        notifyListeners();
        message = 'Your account request has been sent successfully.';
        return {'success': !hasError, 'message': message};
      }
      setAuthenticatedUser(
        token: responseData['idToken'],
        userId: responseData['localId'],
      );
      hasError = true;
      message = 'Authentication succeeded';
      // _authenticatedUser.isEnabled
      //     ? _userSubject.add(true)
      //     : _userSubject.add(false);
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'This password is invalid';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email is already taken';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  // void setAuthTimeout(int time) {
  //   _authTimer = Timer(Duration(seconds: time), refreshAuthToken);
  // }

  void autoAuthenticate() async {
    _isLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    // final String expiryTimeString = prefs.getString('expiryTime');
    final String userId = prefs.getString('userId');
    if (token != null) {
      // final DateTime now = DateTime.now();
      // final parsedExpiryTime = DateTime.parse(expiryTimeString);
      // await refreshAuthToken();
      // token = prefs.getString('token');
      // if (parsedExpiryTime.isBefore(now)) {
      await fetchUsers();
      // await refreshAuthToken();
      _isLoading = false;
      notifyListeners();
      // return;
      // }
      setAuthenticatedUser(token: token, userId: userId);
      _userSubject.add(true);
      // final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      // setAuthTimeout(tokenLifespan);
      notifyListeners();
    }
  }

  // void refreshAuthToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String refreshToken = await prefs.get("refreshToken");
  //   final String userId = prefs.getString('userId');
  //   final http.Response response = await http.post(
  //       "https://securetoken.googleapis.com/v1/token?key=${key}",
  //       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  //       body: "grant_type=refresh_token&refresh_token=$refreshToken");
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     Map<String, dynamic> responseBody = json.decode(response.body);
  //     await prefs.setString("token", responseBody["id_token"]);
  //     await prefs.setString("refreshToken", responseBody["refresh_token"]);

  //     await prefs.setString("expiryTime", responseBody["expires_in"]);
  //     setAuthTimeout(int.parse(responseBody["expires_in"]));
  //     setAuthenticatedUser(token: responseBody["id_token"], userId: userId);
  //     _userSubject.add(true);
  //     notifyListeners();
  //   } else {
  //     print("Refresh Token Status Error: ${response.body}");
  //   }
  // }

  void logout() async {
    _authenticatedUser = null;
    // _authTimer.cancel();
    _userSubject.add(false);
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove('token');
    // await prefs.remove('userEmail');
    // await prefs.remove('userId');
    // await prefs.remove('expiryTime');
    // await prefs.remove('refreshToken');
  }
}

//.........................................................Model Changed..........................................................................//

class UtilityModel extends ConnectedModel {
  bool get isLoading {
    return _isLoading;
  }
}
