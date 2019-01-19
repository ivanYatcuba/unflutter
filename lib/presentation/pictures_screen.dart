import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unflutter/api/model.dart';
import 'package:unflutter/redux/action.dart';
import 'package:unflutter/redux/state.dart';
import 'package:transparent_image/transparent_image.dart';

class PicturesScreen extends StatelessWidget {
  PicturesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<UnflatterState, PicturesScreenViewModel>(
      converter: (store) {
        PicturesScreenState state = store.state.picturesScreenState;
        if (state.isUserInfoLoaded() == false && state.error == null) {
          store.dispatch(LoadUserInfoAction());
        }
        return PicturesScreenViewModel(
            userInfo: state.userInfo, error: state.error, photo: state.photo);
      },
      builder: (BuildContext context, PicturesScreenViewModel vm) {
        if (vm.error != null) {
          return Center(child: Text(vm.error.toString()));
        }
        if (vm.userInfo != null) {
          return PicturesScreenInfo(userInfo: vm.userInfo, photo: vm.photo);
        } else {
          return PicturesScreenLoading(picturesScreenViewModel: vm);
        }
      },
    );
  }
}

class PicturesScreenViewModel {
  final UserInfo userInfo;
  final Photo photo;
  final Error error;

  PicturesScreenViewModel({this.userInfo, this.error, this.photo});
}

class PicturesScreenLoading extends StatelessWidget {
  final PicturesScreenViewModel picturesScreenViewModel;

  PicturesScreenLoading({Key key, @required this.picturesScreenViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SpinKitFadingCube(
              color: Colors.white,
              size: 60,
            )));
  }
}

class PicturesScreenInfo extends StatelessWidget {
  final UserInfo userInfo;
  final Photo photo;

  PicturesScreenInfo({Key key, @required this.userInfo, this.photo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: new Text(userInfo.username),
            leading: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new CircleAvatar(
                  backgroundImage: NetworkImage(userInfo.profile_image.medium)),
            )),
        body: _buildRandomImage());
  }

  Widget _buildRandomImage() {
    if (photo != null) {
      return Stack(
        children: <Widget>[
          Center(child: CircularProgressIndicator()),
          Center(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: photo.urls.full,
            ),
          ),
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
