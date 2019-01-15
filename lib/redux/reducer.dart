// The reducer, which takes the previous count and increments it in response
// to an Increment action.

import 'package:redux/redux.dart';
import 'package:unflutter/redux/action.dart';
import 'package:unflutter/redux/state.dart';

final unsplashReducer = combineReducers<UnflatterState>([
  TypedReducer<UnflatterState, TryLoginAction>((state, action) => state),
]);
