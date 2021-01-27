import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_demo/Blocs/bloc.dart';
import 'package:library_demo/Blocs/books_bloc.dart';
import 'package:library_demo/Blocs/global_state_bloc.dart';
import 'package:library_demo/Models/book.dart';
import 'package:library_demo/Screens/profile_screen.dart';
import 'package:library_demo/Widgets/book_list_tile.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  GlobalStateBloc _globalBloc;
  BooksBloc _bloc;
  @override
  void initState() {
    _globalBloc = BlocProvider.of<GlobalStateBloc>(context);
    _bloc = BlocProvider.of<BooksBloc>(context);
    _bloc.fetchBooks();
    _bloc.fetchFavoriteBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Книги'),
        trailing: GestureDetector(
          onTap: () => ProfileScreen.showProfilePopup(context, _globalBloc),
          child: Icon(CupertinoIcons.gear),
        ),
      ),
      child: StreamBuilder<List<Book>>(
          stream: _bloc.booksStream,
          initialData: _bloc.books,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(radius: 24),
              );
            }
            if (snapshot.hasData) {
              return Material(
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final book = snapshot.data[index];
                    return BookListTile(
                      title: book.name,
                      subtitle: book.desc,
                      isFavorite: _bloc.isFavorite(book),
                      onTap: () => _bloc.switchFavorite(book),
                    );
                  },
                  separatorBuilder: (ctx, index) => Divider(),
                  itemCount: snapshot.data.length,
                ),
              );
            }
            return Center(
              child: Text('Нет удалось загрузить книги'),
            );
          }),
    );
  }
}
