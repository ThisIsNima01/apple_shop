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

  static void saveUserId(String userId) {
    _sharedPrefs.setString('user_id', userId);
  }

  static String getUserId() {
    return _sharedPrefs.getString('user_id') ?? '';
  }

  static void saveUsername(String username) {
    _sharedPrefs.setString('username', username);
  }

  static String getUsername() {
    return _sharedPrefs.getString('username') ?? 'کاربر';
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
