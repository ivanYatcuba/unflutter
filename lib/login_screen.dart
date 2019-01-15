import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:unflutter/redux/action.dart';
import 'package:unflutter/redux/state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<UnflatterState, LoginScreenViewModel>(
        converter: (store) {
      return LoginScreenViewModel(
          state: store.state,
          onLoginButtonPressed: () {
            store.dispatch(TryLoginAction());
          });
    }, builder: (BuildContext context, LoginScreenViewModel vm) {
      if (vm.state.loginState.isUserLoggedIn()) {
        return Text("ff");
      } else {
        return Center(
          child: RaisedButton(
            onPressed: vm.onLoginButtonPressed,
            child: Text("Login"),
          ),
        );
      }
    });
  }
}

class LoginScreenViewModel {
  final UnflatterState state;
  final void Function() onLoginButtonPressed;

  LoginScreenViewModel({this.state, this.onLoginButtonPressed});
}
