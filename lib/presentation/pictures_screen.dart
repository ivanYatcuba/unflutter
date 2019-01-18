import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:unflutter/redux/action.dart';
import 'package:unflutter/redux/state.dart';

class PicturesScreen extends StatelessWidget {
  PicturesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData.dark(),
      title: "",
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text(""),
          ),
          body: new StoreConnector<UnflatterState, PicturesScreenViewModel>(
              converter: (store) {
                return PicturesScreenViewModel(
                    state: store.state,
                    onStartLoadUserInfo: () =>
                        store.dispatch(LoadUserInfoAction()));
          }, builder: (BuildContext context, PicturesScreenViewModel vm) {
            if (vm.state.picturesScreenState.error != null) {
              return Center(
                  child: Text(vm.state.picturesScreenState.error.toString()));
            } else if (vm.state.picturesScreenState.userInfo == null) {
              vm.onStartLoadUserInfo();
              return Center(child: Text("Loading..."));
            } else {
              return Center(
                  child: Text(vm.state.picturesScreenState.userInfo.email));
            }
          })),
    );
  }
}

class PicturesScreenViewModel {
  final UnflatterState state;

  final void Function() onStartLoadUserInfo;

  PicturesScreenViewModel({this.state, this.onStartLoadUserInfo});
}
