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
  }

  setToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  Future<String> getToken() async {
    await initSp();
    token = sharedPreferences.getString('token');
    return token;
  }

  removeToken() async {
    await sharedPreferences.remove('token');
  }
}