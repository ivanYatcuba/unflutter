import 'package:unflutter/auth/token.dart';

/// Base class for unsplash app action
abstract class UnFlatterAction {}

class TryLoginAction extends UnFlatterAction {}

class LoginSucessActionAction extends UnFlatterAction {
  Token token;

  LoginSucessActionAction({this.token});
}
