import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_demo/Blocs/bloc.dart';
import 'package:library_demo/Blocs/books_bloc.dart';
import 'package:library_demo/Models/book.dart';
import 'package:library_demo/Widgets/book_list_tile.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  BooksBloc _bloc;
  @override
  void initState() {
    _bloc = BlocProvider.of<BooksBloc>(context);
    _bloc.fetchBooks();
    _bloc.fetchFavoriteBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Избранное')),
      child: StreamBuilder<List<Book>>(
          stream: _bloc.favoriteBooksStream,
          initialData: _bloc.favoriteBooks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(radius: 24),
              );
            }
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return Material(
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final book = snapshot.data[index];
                    return BookListTile(
                      title: book.name,
                      subtitle: book.desc,
                      isFavorite: true,
                      onTap: () => _bloc.switchFavorite(book),
                    );
                  },
                  separatorBuilder: (ctx, index) => Divider(),
                  itemCount: snapshot.data.length,
                ),
              );
            }
            return Center(
              child: Text('У вас пока нет избранных книг'),
            );
          }),
    );
  }
}
