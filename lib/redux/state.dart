import 'package:unflutter/api/model.dart';
import 'package:unflutter/auth/token.dart';

class UnflatterState {
  LoginState loginState;
  PicturesScreenState picturesScreenState;

  UnflatterState({this.loginState, this.picturesScreenState});

  static UnflatterState initial() {
    return UnflatterState(loginState: LoginState(token: null),
        picturesScreenState: PicturesScreenState(userInfo: null));
  }
}

class LoginState {
  Token token;

  LoginState({this.token});

  bool isUserLoggedIn() {
    return token != null;
  }
}

class PicturesScreenState {
  UserInfo userInfo;
  Exception error;

  PicturesScreenState({this.userInfo, this.error});
}
