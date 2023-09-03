import 'package:apple_shop/di/di.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPrefs = locator.get();

  static void saveToken(String token) {
    _sharedPrefs.setString('access_token', token);
    authChangeNotifier.value = token;
  }

  static String readAuth() {
    return _sharedPrefs.getString('access_token') ?? '';
  }

  static void logout() {
    _sharedPrefs.clear();
    authChangeNotifier.value = null;
  }

  static bool isLoggedIn() => readAuth().isNotEmpty;
}
