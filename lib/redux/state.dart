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

  String accessToken() {
    return token.accessToken;
  }

  bool isUserLoggedIn() {
    return token != null;
  }
}

class PicturesScreenState {
  UserInfo userInfo;
  Error error;
  Photo photo;

  PicturesScreenState({this.userInfo, this.error, this.photo});

  bool isUserInfoLoaded() {
    return userInfo != null;
  }

  bool hasError() {
    return error != null;
  }

}
