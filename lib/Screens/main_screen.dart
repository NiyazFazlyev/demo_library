import 'package:flutter/cupertino.dart';
import 'package:library_demo/Blocs/bloc.dart';
import 'package:library_demo/Blocs/books_bloc.dart';
import 'package:library_demo/Screens/authors_screen.dart';
import 'package:library_demo/Screens/books_screen.dart';
import 'package:library_demo/Screens/favorites_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';

  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;
  BooksBloc _booksBloc = BooksBloc();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              label: 'Избранное',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book),
              label: 'Книги',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_2),
              label: 'Авторы',
            ),
          ],
        ),
        tabBuilder: (context, pageIndex) {
          switch (pageIndex) {
            case 0:
              return CupertinoTabView(
                builder: (ctx) => BlocProvider(bloc: _booksBloc, child: FavoritesScreen()),
              );
            case 2:
              return CupertinoTabView(
                builder: (ctx) => AuthorsScreen(),
              );

            default:
              return CupertinoTabView(
                builder: (ctx) => BlocProvider(bloc: _booksBloc, child: BooksScreen()),
              );
          }
        });
  }
}
