import 'dart:async';

import 'package:library_demo/Models/book.dart';
import 'package:library_demo/Sdk/sdk.dart';

import 'bloc.dart';

class BooksBloc implements Bloc {
  final StreamController _booksController = StreamController<List<Book>>.broadcast();
  Stream<List<Book>> get booksStream => _booksController.stream;
  List<Book> books = [];

  final StreamController _favoriteBooksController = StreamController<List<Book>>.broadcast();
  Stream<List<Book>> get favoriteBooksStream => _favoriteBooksController.stream;
  List<Book> favoriteBooks = [];

  void fetchBooks() async {
    final allBooks = await SDK().fetchBooks();
    books = allBooks;
    _booksController.add(books);
  }

  void fetchFavoriteBooks() async {
    final fbooks = await SDK().fetchFavoriteBooks();
    favoriteBooks = fbooks;
    _booksController.add(books);
    _favoriteBooksController.add(favoriteBooks);
  }

  bool isFavorite(Book book) {
    return favoriteBooks?.contains(book) ?? false;
  }

  void switchFavorite(Book book) async {
    if (isFavorite(book)) {
      favoriteBooks.remove(book);
      _booksController.add(books);
      _favoriteBooksController.add(favoriteBooks);
      final res = await SDK().removeFromFavorities(book);
      if (!res) {
        favoriteBooks.add(book);
        _booksController.add(books);
        _favoriteBooksController.add(favoriteBooks);
      }
    } else {
      favoriteBooks.add(book);
      _booksController.add(books);
      _favoriteBooksController.add(favoriteBooks);
      final res = await SDK().addToFavorities(book);
      if (!res) {
        favoriteBooks.remove(book);
        _booksController.add(books);
        _favoriteBooksController.add(favoriteBooks);
      }
    }
  }

  @override
  void dispose() {
    _booksController.close();
    _favoriteBooksController.close();
  }
}
