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
          },
          onNavigateToPicturesScreen: () {
            store.dispatch(
                GoToPicturesScreenAction(navigator: Navigator.of(context)));
          });
    }, builder: (BuildContext context, LoginScreenViewModel vm) {
      if (vm.state.loginState.isUserLoggedIn()) {
        vm.onNavigateToPicturesScreen();
      }
      return Center(
        child: RaisedButton(
          onPressed: vm.onLoginButtonPressed,
          child: Text("Login"),
        ),
      );
    });
  }
}

class LoginScreenViewModel {
  final UnflatterState state;
  final void Function() onLoginButtonPressed;
  final void Function() onNavigateToPicturesScreen;

  LoginScreenViewModel(
      {this.state, this.onLoginButtonPressed, this.onNavigateToPicturesScreen});
}
