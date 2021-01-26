import 'package:flutter/cupertino.dart';
import 'package:library_demo/Blocs/bloc.dart';
import 'package:library_demo/Blocs/login_bloc.dart';
import 'package:library_demo/Widgets/error_alert.dart';

import 'auth_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _bloc;
  TextEditingController _loginController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _bloc = BlocProvider.of<LoginBloc>(context);
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginButtonPressed() {
    final login = _loginController.text;
    final password = _passwordController.text;
    try {
      _bloc.login(login, password);
    } catch (e) {
      ErrorAlert.show(context, 'Авторизация не удалась', message: 'Попробуйте снова');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Авторизация'),
      ),
      resizeToAvoidBottomInset: false,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text('Email:'),
              SizedBox(height: 12),
              CupertinoTextField(
                controller: _loginController,
                placeholder: 'Введите ваш email...',
              ),
              SizedBox(height: 12),
              Text('Пароль:'),
              SizedBox(height: 12),
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Введите ваш пароль...',
                obscureText: true,
              ),
              SizedBox(height: 20),
              Center(
                child: CupertinoButton(
                  child: Text('Войти'),
                  color: CupertinoColors.activeBlue,
                  onPressed: loginButtonPressed,
                ),
              ),
              SizedBox(height: 12),
              Center(
                child: CupertinoButton(
                  child: Text('Зарегистрироваться'),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                      builder: (ctx) => BlocProvider(bloc: _bloc, child: AuthScreen()),
                      title: "Регистрация",
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
