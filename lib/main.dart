import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:unflutter/presentation/login_screen.dart';
import 'package:unflutter/presentation/pictures_screen.dart';
import 'package:unflutter/redux/state.dart';
import 'package:unflutter/redux/store.dart';

void main() {
  runApp(new UnflatterApp(
    title: 'Unflatter',
    store: unflatterStore,
  ));
}

class UnflatterApp extends StatelessWidget {
  final Store<UnflatterState> store;
  final String title;

  UnflatterApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<UnflatterState>(
      store: store,
      child: new MaterialApp(
        theme: new ThemeData.dark(),
        title: title,
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: _getRoute,
      ),
    );
  }

  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return _buildRoute(settings, LoginScreen());
      case '/pictures':
        return _buildRoute(settings, PicturesScreen());
      default:
        return _buildRoute(settings, LoginScreen());
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
