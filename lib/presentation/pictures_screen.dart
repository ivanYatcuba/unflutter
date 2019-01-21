import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unflutter/api/model.dart';
import 'package:unflutter/presentation/hero.dart';
import 'package:unflutter/redux/action.dart';
import 'package:unflutter/redux/state.dart';

class PicturesScreen extends StatelessWidget {
  PicturesScreen({Key key}) : super(key: key);

  final PicturesScreenInfoState screenInfoState = PicturesScreenInfoState();

  @override
  Widget build(BuildContext context) {
    PicturesScreenInfo screenInfo =
    PicturesScreenInfo(picturesScreenInfoState: screenInfoState);
    return new StoreConnector<UnflatterState, PicturesScreenViewModel>(
      converter: (store) {
        PicturesScreenState state = store.state.picturesScreenState;
        if (state.isUserInfoLoaded() == false && state.error == null) {
          store.dispatch(LoadUserInfoAction());
        }
        screenInfo.picturesScreenInfoState.loadMoreData =
            (page) => store.dispatch(LoadPhotosAction(page: page));
        return PicturesScreenViewModel(
            userInfo: state.userInfo,
            error: state.error,
            photos: state.photos,
            token: store.state.loginState.accessToken());
      },
      builder: (BuildContext context, PicturesScreenViewModel vm) {
        if (vm.error != null) {
          return Center(child: Text(vm.error.toString()));
        }
        if (vm.userInfo != null) {
          screenInfo.picturesScreenInfoState.userInfo = vm.userInfo;
          screenInfo.picturesScreenInfoState.token = vm.token;
          if (vm.photos != null) {
            //screenInfo.picturesScreenInfoState.currentPage = vm.photos.currentPage;
            screenInfo.picturesScreenInfoState.addItems(vm.photos.photos);
          }
          return screenInfo;
        } else {
          return PicturesScreenLoading(picturesScreenViewModel: vm);
        }
      },
    );
  }
}

class PicturesScreenViewModel {
  final UserInfo userInfo;
  final PhotoList photos;
  final Error error;
  final String token;

  PicturesScreenViewModel({this.userInfo, this.error, this.photos, this.token});
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

class PicturesScreenInfo extends StatefulWidget {
  final PicturesScreenInfoState picturesScreenInfoState;

  PicturesScreenInfo({Key key, this.picturesScreenInfoState}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return picturesScreenInfoState;
  }
}

class PicturesScreenInfoState extends State<PicturesScreenInfo> {
  UserInfo userInfo;
  Set<Photo> photos = Set();
  int currentPage = 0;
  String token;

  Function(int) loadMoreData;

  bool pendingRequest = false;

  final ScrollController _scrollController = new ScrollController();

  addItems(List<Photo> photos) {
    this.photos.addAll(photos);
    pendingRequest = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!pendingRequest) {
          currentPage++;
          _getMoreData(currentPage);
        }
      }
    });

    return Scaffold(
        appBar: new AppBar(
            title: new Text(userInfo.username),
            leading: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new CircleAvatar(
                  backgroundImage: NetworkImage(userInfo.profile_image.medium)),
            )),
        body: _buildList());
  }

  _getMoreData(int page) {
    loadMoreData(page);
  }

  Widget _buildList() {
    StaggeredGridView gridView = StaggeredGridView.countBuilder(
      primary: false,
      itemCount: photos.length,
      crossAxisCount: 4,
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      controller: _scrollController,
      itemBuilder: (context, index) => _buildTile(photos.toList(), index),
      staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
    );
    return gridView;
  }

  Widget _buildTile(List<Photo> photoList, int index) {
    if (index == photoList.length - 1) {
      return new Center(
          child: new SpinKitThreeBounce(
            color: Colors.white,
            size: 40.0,
          ));
    } else {
      return new Card(
        child: new Center(
          child: HeroAnimation(
              thumb: photoList[index].urls.thumb,
              full: photoList[index].urls.full),
        ),
      );
    }
  }
}
