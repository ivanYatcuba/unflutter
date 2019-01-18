import 'package:flutter/material.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unflutter/api/unsplash_api.dart';
import 'package:unflutter/auth/flutter_auth.dart';
import 'package:unflutter/auth/model/config.dart';
import 'package:unflutter/auth/oauth.dart';
import 'package:unflutter/auth/token.dart';
import 'package:unflutter/presentation/pictures_screen.dart';
import 'package:unflutter/redux/action.dart';
import 'package:unflutter/redux/state.dart';

final OAuth flutterOAuth = new FlutterOAuth(new Config(
    "https://unsplash.com/oauth/authorize",
    "https://unsplash.com/oauth/token",
    "1aebcd50d4460f3225bd7163cbbb50bb9d13d0e36409c7671d19fa0930892aa3",
    "84ad9cad29554ffff2909118c66d21f7b62aa14ee2a61ed6bc0a559a919e16c2",
    "http://localhost:8080",
    "code",
    forceWebiew: true));

final unflatterEpics = combineEpics<UnflatterState>([
  TypedEpic<UnflatterState, TryLoginAction>((actions, store) {
    return Observable(actions)
        .ofType(TypeToken<TryLoginAction>())
        .switchMap((action) async* {
      Token token = await flutterOAuth.performAuthorization();
      print("token is: ${token.accessToken}");
      yield LoginSucessActionAction(token: token);
    });
  }),
  TypedEpic<UnflatterState, GoToPicturesScreenAction>((actions, store) {
    return Observable(actions)
        .ofType(TypeToken<GoToPicturesScreenAction>())
        .switchMap((action) async* {
      action.navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PicturesScreen()),
          ModalRoute.withName("/Home"));
    });
  }),
  TypedEpic<UnflatterState, LoadUserInfoAction>((actions, store) {
    return Observable(actions)
        .ofType(TypeToken<LoadUserInfoAction>())
        .switchMap((action) async* {
      UnpslashApi unpslashApi = UnpslashApi();
      try {
        yield UserInfoLoadedAction(
            userInfo: await unpslashApi
                .fetchUserInfo(store.state.loginState.token.accessToken));
      } catch (e) {
        yield UserInfoLoadedAction(error: e);
      }
    });
  })
]);
