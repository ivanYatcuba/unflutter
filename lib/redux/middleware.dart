import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unflutter/api/model.dart';
import 'package:unflutter/api/unsplash_api.dart';
import 'package:unflutter/auth/flutter_auth.dart';
import 'package:unflutter/auth/model/config.dart';
import 'package:unflutter/auth/oauth.dart';
import 'package:unflutter/auth/token.dart';
import 'package:unflutter/redux/action.dart';
import 'package:unflutter/redux/state.dart';

final unflatterEpics = combineEpics<UnflatterState>([
  TypedEpic<UnflatterState, TryLoginAction>((actions, store) {
    return Observable(actions)
        .ofType(TypeToken<TryLoginAction>())
        .switchMap((action) async* {
      final OAuth flutterOAuth = new FlutterOAuth(new Config(
          "https://unsplash.com/oauth/authorize",
          "https://unsplash.com/oauth/token",
          "7c86b034a2bb2f0c5b77e49d770ee25689f94e49fdfa8b3911dd36c7ee22b160",
          "8c2923d2b1d08cb6d1e48d39d58b887e063c486bd6a90362eea213eb2f1c95f9",
          "http://localhost:8080",
          "code",
          forceWebiew: true));
      Token token = await flutterOAuth.performAuthorization();
      print("token is: ${token.accessToken}");
      yield LoginSucessActionAction(token: token);
      yield NavigateToAction.replace("/pictures");
    });
  }),
  TypedEpic<UnflatterState, LoadUserInfoAction>((actions, store) {
    return Observable(actions)
        .ofType(TypeToken<LoadUserInfoAction>())
        .switchMap((action) async* {
      UnpslashApi unpslashApi = UnpslashApi();
      try {
        UserInfo userInfo = await unpslashApi
            .fetchUserInfo(store.state.loginState.accessToken());
        yield UserInfoLoadedAction(userInfo: userInfo);
        yield LoadPhotosAction(page: 0);
      } catch (e) {
        yield UserInfoLoadedAction(error: e);
      }
    });
  }),
  TypedEpic<UnflatterState, LoadRandomPhotoAction>((actions, store) {
    return Observable(actions)
        .ofType(TypeToken<LoadRandomPhotoAction>())
        .switchMap((action) async* {
      UnpslashApi unpslashApi = UnpslashApi();
      try {
        Photo photo = await unpslashApi
            .fetchRandomPhoto(store.state.loginState.accessToken());
        yield RandomPhotoLoadedAction(photo: photo);
      } catch (e) {
        yield UserInfoLoadedAction(error: e);
      }
    });
  }),
  TypedEpic<UnflatterState, LoadPhotosAction>((actions, store) {
    return Observable(actions)
        .ofType(TypeToken<LoadPhotosAction>())
        .switchMap((action) async* {
      UnpslashApi unpslashApi = UnpslashApi();
      try {
        PhotoList photos = await unpslashApi.fetchPhotoList(
            store.state.loginState.accessToken(), action.page);
        yield PhotosLoadedAction(photos: photos);
      } catch (e) {
        yield PhotosLoadedAction(error: e);
      }
    });
  })
]);
