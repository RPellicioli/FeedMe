import 'dart:async';

import 'package:feed_me_app/entities/user.dart';
import 'package:feed_me_app/services/login_service.dart';
import 'package:feed_me_app/services/users_service.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends Model {
  User userData = User();
  bool isLoading = false;
  bool loggedId = false;
  String userToken;
  Position currentPosition;
  String currentAddress;
  List<int> foodIds = new List();

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  void signUp(
      {@required User userData,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    postUser(userData).then((id) async {
      signIn(
          email: userData.email,
          password: userData.password,
          onSuccess: () async {
            isLoading = false;
            notifyListeners();
            onSuccess();
          },
          onFail: () {
            isLoading = false;
            notifyListeners();
            onFail();
          });
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      onFail();
    });
  }

  void signIn(
      {@required String email,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    login(email, password).then((data) async {
      await _loadCurrentUser(data["userId"], data["token"]);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userEmail', email);
      prefs.setString('userPassword', password);

      userToken = data["token"];

      loggedId = true;
      isLoading = false;
      notifyListeners();
      onSuccess();
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      onFail();
    });
  }

  void signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userEmail', null);
    prefs.setString('userPassword', null);

    userData = User();
    loggedId = false;
    userToken = "";
    notifyListeners();
  }

  bool isLoggedIn() {
    return loggedId;
  }

  Future<Null> _loadCurrentUser(int userId, String a) async {
    userData = await getUser(userId, a);
    notifyListeners();
  }
}
