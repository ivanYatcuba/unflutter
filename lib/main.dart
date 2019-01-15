import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:unflutter/login_screen.dart';
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
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text(title),
            ),
            body: LoginScreen()),
      ),
    );
  }
}
