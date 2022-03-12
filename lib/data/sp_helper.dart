import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper() {
    initSp();

  }
  String token;
  SharedPreferences sharedPreferences;
  initSp() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getToken();
  }

  setToken(String token) async {
    log(token);
    await sharedPreferences.setString('token', token);
  }

  String getToken()  {

    token = sharedPreferences.getString('token');
    return token;
  }

  removeToken() async {
    await sharedPreferences.remove('token');
  }
}