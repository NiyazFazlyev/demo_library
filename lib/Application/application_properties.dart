import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ApplicationProperties {
  static bool get isDevelopmentBuild => kDebugMode;

  static SharedPreferences _preferences;

  static Future load() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() async {
    return _preferences.clear();
  }

  static void setString(String key, String value) {
    _preferences.setString(key, value);
  }

  static String getString(String key) {
    return _preferences.getString(key);
  }

  static void setBool(String key, bool value) {
    _preferences.setBool(key, value);
  }

  static bool getBool(String key) {
    return _preferences.getBool(key);
  }

  static void setDouble(String key, double value) {
    _preferences.setDouble(key, value);
  }

  static double getDouble(String key) {
    return _preferences.getDouble(key);
  }

  static void setInt(String key, int value) {
    _preferences.setInt(key, value);
  }

  static int getInt(String key) {
    return _preferences.getInt(key);
  }

  static bool containsKey(String key) {
    return _preferences.containsKey(key);
  }

  static void removeKey(String key) {
    _preferences.remove(key);
  }
}
