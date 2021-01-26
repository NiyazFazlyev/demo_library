import 'package:flutter/cupertino.dart';

class ErrorAlert extends StatelessWidget {
  final String title;
  final String message;
  ErrorAlert(this.title, {this.message});
  static Future<void> show(BuildContext context, String title, {String message}) {
    return showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return ErrorAlert(title, message: message);
        });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: message != null ? Text(message) : Container,
      actions: [
        CupertinoDialogAction(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
