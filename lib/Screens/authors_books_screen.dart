import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_demo/Models/author.dart';
import 'package:library_demo/Models/book.dart';
import 'package:library_demo/Sdk/sdk.dart';
import 'package:library_demo/Widgets/book_list_tile.dart';

class AuthorsBooksScreen extends StatelessWidget {
  final Author author;
  AuthorsBooksScreen(this.author);
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(author.name ?? ''),
      ),
      child: FutureBuilder<List<Book>>(
        future: SDK().fetchAuthorsBooks(author.id),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(radius: 24),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Произошла ошибка'),
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
                    isFavorite: null,
                    onTap: null,
                  );
                },
                separatorBuilder: (ctx, index) => Divider(),
                itemCount: snapshot.data.length,
              ),
            );
          } else {
            return Center(
              child: Text('У этого автора нет книг'),
            );
          }
        },
      ),
    );
  }
}
