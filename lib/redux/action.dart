import 'package:unflutter/api/model.dart';
import 'package:unflutter/auth/token.dart';

/// Base class for unsplash app action
abstract class UnFlatterAction {}

class TryLoginAction extends UnFlatterAction {}

class LoginSucessActionAction extends UnFlatterAction {
  Token token;

  LoginSucessActionAction({this.token});
}

class LoadUserInfoAction extends UnFlatterAction {}

class UserInfoLoadedAction extends UnFlatterAction {
  UserInfo userInfo;
  Error error;

  UserInfoLoadedAction({this.userInfo, this.error});
}

class LoadRandomPhotoAction extends UnFlatterAction {}

class RandomPhotoLoadedAction extends UnFlatterAction {
  Photo photo;
  Error error;

  RandomPhotoLoadedAction({this.photo, this.error});
}