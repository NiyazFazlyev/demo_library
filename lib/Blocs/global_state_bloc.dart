import 'dart:async';

import 'package:library_demo/Application/credential.dart';
import 'bloc.dart';

enum GlobalState {
  unauthorized,
  authorized,
}

class GlobalStateBloc implements Bloc {
  final _stateController = StreamController<GlobalState>.broadcast();
  Stream<GlobalState> get stateStream => _stateController.stream;
  GlobalState get currentState => _currentState();

  GlobalState _currentState() {
    return CredentialStorage.isAthorized ? GlobalState.authorized : GlobalState.unauthorized;
  }

  void updateState() {
    final state = _currentState();
    _stateController.add(state);
  }

  @override
  void dispose() {
    _stateController.close();
  }
}
