import 'package:flutter/cupertino.dart';
import 'package:library_demo/Blocs/bloc.dart';
import 'package:library_demo/Blocs/global_state_bloc.dart';
import 'package:library_demo/Screens/login_screen.dart';
import 'package:library_demo/Screens/main_screen.dart';

import 'Blocs/login_bloc.dart';

class MyLibrary extends StatefulWidget {
  @override
  _MyLibraryState createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Library',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(bloc: GlobalStateBloc(), child: GlobalStateObserver()),
    );
  }
}

class GlobalStateObserver extends StatefulWidget {
  @override
  _GlobalStateObserverState createState() => _GlobalStateObserverState();
}

class _GlobalStateObserverState extends State<GlobalStateObserver> {
  GlobalStateBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<GlobalStateBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GlobalState>(
        stream: _bloc.stateStream,
        initialData: _bloc.currentState,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox();
          }
          return _buildCurrentState(snapshot.data);
        });
  }

  Widget _buildCurrentState(GlobalState state) {
    switch (state) {
      case GlobalState.unauthorized:
        return BlocProvider(bloc: LoginBloc(_bloc), child: LoginScreen());

      default:
        return MainScreen();
    }
  }
}
