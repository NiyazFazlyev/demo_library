import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Book extends Equatable {
  final int id;
  final String name;
  final String desc;
  final int authorId;
  final String imageUrl;

  Book(
    this.id,
    this.name,
    this.desc,
    this.authorId,
    this.imageUrl,
  );

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      json['id'],
      json['name'],
      json['desc'],
      json['author_id'],
      json['image'],
    );
  }

  @override
  List<Object> get props => [id, name];
}
