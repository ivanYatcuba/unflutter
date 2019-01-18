// Create your store as a final variable in a base Widget. This works better
// with Hot Reload than creating it directly in the `build` function.
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:unflutter/redux/middleware.dart';
import 'package:unflutter/redux/reducer.dart';
import 'package:unflutter/redux/state.dart';

final unflatterStore = new Store<UnflatterState>(unsplashReducer,
    initialState: UnflatterState.initial(),
    middleware: [EpicMiddleware<UnflatterState>(unflatterEpics)]);
