import 'package:flutter/cupertino.dart';
import 'package:library_demo/Blocs/global_state_bloc.dart';
import 'package:library_demo/Models/profile.dart';
import 'package:library_demo/Sdk/sdk.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalStateBloc _globalBloc;
  ProfileScreen(this._globalBloc);
  static void showProfilePopup(
    BuildContext context,
    GlobalStateBloc globalBloc, {
    bool useRootNavigator = true,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => ProfileScreen(globalBloc),
      useRootNavigator: useRootNavigator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Stack(children: [
          Container(
            width: double.infinity,
            color: CupertinoColors.white,
            child: Column(
              children: [
                Spacer(),
                FutureBuilder<Profile>(
                    future: SDK().fetchProfile(),
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Text(snapshot.data.name ?? ''),
                            SizedBox(height: 12),
                            Text(snapshot.data.email ?? ''),
                          ],
                        );
                      }
                      return Container();
                    }),
                CupertinoButton(
                  child: Text('Logout'),
                  onPressed: () async {
                    await SDK().logout();
                    _globalBloc.updateState();
                    Navigator.of(context).pop();
                  },
                ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(CupertinoIcons.multiply_circle_fill),
            ),
          ),
        ]),
      ),
    );
  }
}
