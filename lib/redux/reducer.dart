// The reducer, which takes the previous count and increments it in response
// to an Increment action.

import 'package:redux/redux.dart';
import 'package:unflutter/redux/action.dart';
import 'package:unflutter/redux/state.dart';

final unsplashReducer = combineReducers<UnflatterState>([
  TypedReducer<UnflatterState, TryLoginAction>((state, action) => state),
  TypedReducer<UnflatterState, LoginSucessActionAction>((state, action) {
    state.loginState.token = action.token;
    return state;
  }),
  TypedReducer<UnflatterState, LoadUserInfoAction>((state, action) => state),
  TypedReducer<UnflatterState, UserInfoLoadedAction>((state, action) {
    state.picturesScreenState.userInfo = action.userInfo;
    state.picturesScreenState.error = action.error;
    return state;
  }),
  TypedReducer<UnflatterState, PhotosLoadedAction>((state, action) {
    state.picturesScreenState.photos = action.photos;
    state.picturesScreenState.error = action.error;
    return state;
  }),
]);
