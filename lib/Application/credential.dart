import 'dart:async';
import 'package:library_demo/Application/application_properties.dart';

class CredentialStorage {
  static const _tokenKey = 'user_token';

  static bool get isAthorized => token != null;
  static String get token => ApplicationProperties.getString(_tokenKey);

  static Future<void> setAthorized(String token) async {
    if (token == null) return;
    ApplicationProperties.setString(_tokenKey, token);
  }

  static Future<void> setUnathorized() async {
    ApplicationProperties.removeKey(_tokenKey);
  }
}
