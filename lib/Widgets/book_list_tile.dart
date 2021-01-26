import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isFavorite;
  final Function onTap;
  BookListTile({
    this.title = '',
    this.subtitle = '',
    this.onTap,
    this.isFavorite = false,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: isFavorite != null
          ? IconButton(
              icon: Icon(
                isFavorite ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
                color: Colors.red,
              ),
              onPressed: onTap,
            )
          : null,
    );
  }
}
