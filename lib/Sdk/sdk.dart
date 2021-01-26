import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:library_demo/Application/credential.dart';
import 'package:library_demo/Models/author.dart';
import 'package:library_demo/Models/book.dart';
import 'package:library_demo/Models/profile.dart';

class SDK {
  static final SDK _instance = SDK._internal();
  factory SDK() {
    return _instance;
  }

  SDK._internal() {
    dio = Dio(BaseOptions(baseUrl: 'https://mobile.fakebook.press/api/'));
  }

  Dio dio;

  Future<bool> registration(String name, String email, String password, String passwordConfirmation) async {
    final data = json.encode({
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    });
    final response = await dio.post(
      "register",
      data: data,
    );
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<void> login(String email, String password) async {
    final data = json.encode({"email": email, "password": password, "password_confirmation": password});
    final response = await dio.post(
      "login",
      data: data,
    );
    if (response.statusCode == 200) {
      final responseData = response.data['data'];
      final token = responseData['token'];
      CredentialStorage.setAthorized(token);
    }
  }

  Future<void> logout() async {
    final token = CredentialStorage.token;

    try {
      final response = await dio.post(
        "logout",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        // CredentialStorage.setUnathorized();
      }
    } catch (e) {
      print('#SDK# $e');
    }
    CredentialStorage.setUnathorized();
  }

  Future<Profile> fetchProfile() async {
    final token = CredentialStorage.token;

    try {
      final response = await dio.get(
        "me",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final data = response?.data['data'];
        final profile = Profile.fromJson(data);
        return profile;
      }
    } catch (e) {
      print('#SDK# $e');
    }
    return null;
  }

  Future<List<Author>> fetchAuthors() async {
    try {
      final response = await dio.get("authors");
      if (response.statusCode == 200) {
        final data = response?.data['data'] as List;
        List<Author> authors = [];
        data.forEach((element) {
          authors.add(Author.fromJson(element as Map<String, dynamic>));
        });
        return authors;
      }
    } catch (e) {
      print('#SDK# $e');
    }
    return [];
  }

  Future<List<Book>> fetchAuthorsBooks(int authorId) async {
    final response = await dio.get("authors/$authorId/books");
    if (response.statusCode == 200) {
      final data = response?.data['data'] as List;
      List<Book> books = [];
      data.forEach((element) {
        books.add(Book.fromJson(element as Map<String, dynamic>));
      });
      return books;
    }
    return null;
  }

  Future<List<Book>> fetchBooks() async {
    try {
      final response = await dio.get("books");
      if (response.statusCode == 200) {
        final data = response?.data['data'] as List;
        List<Book> books = [];
        data.forEach((element) {
          books.add(Book.fromJson(element as Map<String, dynamic>));
        });
        return books;
      }
    } catch (e) {
      print('#SDK# $e');
    }
    return [];
  }

  Future<List<Book>> fetchFavoriteBooks() async {
    final token = CredentialStorage.token;

    try {
      final response = await dio.get(
        "favorite-books",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final data = response?.data['data'] as List;
        List<Book> books = [];
        data.forEach((element) {
          books.add(Book.fromJson(element as Map<String, dynamic>));
        });
        return books;
      }
    } catch (e) {
      print('#SDK# $e');
    }
    return [];
  }

  Future<bool> addToFavorities(Book book) async {
    final token = CredentialStorage.token;
    try {
      final response = await dio.post(
        "books/${book.id}/add-to-favorites",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('#SDK# $e');
    }
    return false;
  }

  Future<bool> removeFromFavorities(Book book) async {
    final token = CredentialStorage.token;
    try {
      final response = await dio.post(
        "books/${book.id}/remove-from-favorites",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('#SDK# $e');
    }
    return false;
  }
}
