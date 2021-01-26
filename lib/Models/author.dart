import 'package:flutter/material.dart';

@immutable
class Author {
  final int id;
  final String name;
  final String bio;
  final String imageUrl;
  final String birthDate;
  final String diedDate;

  Author(
    this.id,
    this.name,
    this.bio,
    this.imageUrl,
    this.birthDate,
    this.diedDate,
  );

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      json['id'],
      json['name'],
      json['bio'],
      json['image'],
      json['birth_date'],
      json['died_date'],
    );
  }
}
