import 'package:library_demo/Blocs/global_state_bloc.dart';
import 'package:library_demo/Sdk/sdk.dart';

import 'bloc.dart';

class LoginBloc implements Bloc {
  GlobalStateBloc _globalBloc;
  LoginBloc(this._globalBloc);

  void login(String email, String password) async {
    await SDK().login(email, password);
    _globalBloc.updateState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
