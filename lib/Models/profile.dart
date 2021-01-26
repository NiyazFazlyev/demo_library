import 'package:flutter/foundation.dart';

@immutable
class Profile {
  final int id;
  final String name;
  final String email;

  Profile(
    this.id,
    this.name,
    this.email,
  );

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      json['id'],
      json['name'],
      json['email'],
    );
  }
}
