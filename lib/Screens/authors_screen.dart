import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_demo/Models/author.dart';
import 'package:library_demo/Screens/authors_books_screen.dart';
import 'package:library_demo/Screens/profile_screen.dart';
import 'package:library_demo/Sdk/sdk.dart';

class AuthorsScreen extends StatefulWidget {
  @override
  _AuthorsScreenState createState() => _AuthorsScreenState();
}

class _AuthorsScreenState extends State<AuthorsScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Авторы')),
      child: FutureBuilder<List<Author>>(
        future: SDK().fetchAuthors(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            return Material(
              child: ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (ctx, index) => Divider(),
                itemBuilder: (ctx, index) {
                  final author = snapshot.data[index];
                  return ListTile(
                    onTap: () => Navigator.of(context).push(
                      CupertinoPageRoute(builder: (ctx) => AuthorsBooksScreen(author)),
                    ),
                    title: Text(author.name ?? ''),
                    leading: author.imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: author.imageUrl,
                            progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Image.asset('assets/images/avatar_placeholder.png'),
                          )
                        : Image.asset('assets/images/avatar_placeholder.png'),
                  );
                },
              ),
            );
          }
          return Center(
            child: Text('Не удалось получить список авторов'),
          );
        },
      ),
    );
  }
}
