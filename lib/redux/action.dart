import 'package:flutter/material.dart';
import 'package:unflutter/api/model.dart';
import 'package:unflutter/auth/token.dart';

/// Base class for unsplash app action
abstract class UnFlatterAction {}

class TryLoginAction extends UnFlatterAction {}

class LoginSucessActionAction extends UnFlatterAction {
  Token token;

  LoginSucessActionAction({this.token});
}

class GoToPicturesScreenAction extends UnFlatterAction {
  NavigatorState navigator;

  GoToPicturesScreenAction({this.navigator});
}

class LoadUserInfoAction extends UnFlatterAction {}

class UserInfoLoadedAction extends UnFlatterAction {
  UserInfo userInfo;
  Exception error;

  UserInfoLoadedAction({this.userInfo, this.error});
}
