import 'dart:convert';
import 'dart:developer';
import 'package:demo/fake_store/app_config/app_config.dart';
import 'package:demo/fake_store/presentation/bottom.dart';
import 'package:demo/fake_store/presentation/home_screen/home_screen.dart';
import 'package:demo/fake_store/repository/api/login_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginController extends ChangeNotifier {
  bool visibility = true;
  late SharedPreferences sharedPreferences;
Future onLogin(String username, String password, BuildContext context) async {
  log("loginController -> onLogin() started");

  final value = await LoginService.postLoginData(username, password);

  if (value != null) {
    if (value["token"] != null) {
      log("token -> ${value["token"]}");
      storeLoginData(value);
      storeUserToken(value["token"]);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    } else {
      log("Unexpected response format");
    }
  } else {
    log("Else Condition >> Api failed");
  }
}


  void onPressed() {
    visibility = !visibility;
    notifyListeners();
  }

  void storeLoginData(loginReceivedData) async {
    log("storeLoginData()");
    sharedPreferences = await SharedPreferences.getInstance();
    String storeData = jsonEncode(loginReceivedData);
    sharedPreferences.setString(AppConfig.loginData, storeData);
    sharedPreferences.setBool(AppConfig.loggedIn, true);
  }

  void storeUserToken(resData) async {
    log("storeUserToken");
    sharedPreferences = await SharedPreferences.getInstance();
    String dataUser = json.encode(resData);
    sharedPreferences.setString(AppConfig.token, dataUser);
  }
}