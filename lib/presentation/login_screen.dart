import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unflutter/redux/action.dart';
import 'package:unflutter/redux/state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<UnflatterState, LoginScreenViewModel>(
        converter: (store) {
          if (store.state.loginState.isUserLoggedIn() == false) {
            store.dispatch(TryLoginAction());
          }
          return LoginScreenViewModel();
    }, builder: (BuildContext context, LoginScreenViewModel vm) {
      return Scaffold(
          body: Center(
              child: SpinKitFadingCube(
                color: Colors.white,
                size: 60,
              )));
    });
  }
}

class LoginScreenViewModel {}
