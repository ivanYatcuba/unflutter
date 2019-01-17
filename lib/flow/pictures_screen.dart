import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:unflutter/redux/state.dart';

class PicturesScreen extends StatelessWidget {
  PicturesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<UnflatterState, PicturesScreenViewModel>(
        converter: (store) {
      return PicturesScreenViewModel(state: store.state);
    }, builder: (BuildContext context, PicturesScreenViewModel vm) {
      return Center(
        child: Text("data here"),
      );
    });
  }
}

class PicturesScreenViewModel {
  final UnflatterState state;

  PicturesScreenViewModel({this.state});
}
