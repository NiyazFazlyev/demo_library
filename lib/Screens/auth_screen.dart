import 'package:flutter/cupertino.dart';
import 'package:library_demo/Sdk/sdk.dart';
import 'package:library_demo/Widgets/error_alert.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _passwordConfirmationController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  void registrationButtonPressed() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final passwordConfirmation = _passwordConfirmationController.text;
    try {
      final res = await SDK().registration(name, email, password, passwordConfirmation);
      if (res) {
        await ErrorAlert.show(context, 'Регистрация прошла успешно');
        Navigator.of(context).pop();
      }
    } catch (e) {
      await ErrorAlert.show(context, 'Что-то пошло не так', message: '$e');
    }
  }

  Future<void> showAlert(String title, {String message}) {
    return showCupertinoDialog(
        context: context,
        builder: (ctx) {
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Назад',
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text('Введите ваше имя:'),
                SizedBox(height: 12),
                CupertinoTextField(
                  placeholder: 'Ваше имя...',
                  controller: _nameController,
                ),
                SizedBox(height: 12),
                Text('Введите ваш email:'),
                SizedBox(height: 12),
                CupertinoTextField(
                  placeholder: 'Ваш email...',
                  controller: _emailController,
                ),
                SizedBox(height: 32),
                Text('Придумайте пароль:'),
                SizedBox(height: 12),
                CupertinoTextField(
                  placeholder: 'Ваш пароль...',
                  obscureText: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 12),
                Text('Введите пароль еще раз:'),
                SizedBox(height: 12),
                CupertinoTextField(
                  placeholder: 'Ваш пароль...',
                  obscureText: true,
                  controller: _passwordConfirmationController,
                ),
                SizedBox(height: 20),
                Center(
                  child: CupertinoButton(
                    child: Text('Зарегистрироваться'),
                    color: CupertinoColors.activeBlue,
                    onPressed: registrationButtonPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
