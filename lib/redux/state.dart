import 'package:unflutter/auth/token.dart';

class UnflatterState {
  LoginState loginState;

  UnflatterState({this.loginState});

  static UnflatterState initial() {
    return UnflatterState(loginState: LoginState(token: null));
  }
}

class LoginState {
  Token token;

  LoginState({this.token});

  bool isUserLoggedIn() {
    return token != null;
  }
}
