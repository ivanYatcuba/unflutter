import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoHero extends StatefulWidget {
  final String thumb;
  final String full;
  final VoidCallback onTap;
  final bool thumbOnly;

  const PhotoHero({Key key, this.thumb, this.full, this.onTap, this.thumbOnly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PhotoHeroState(
        thumb: thumb, full: full, onTap: onTap, thumbOnly: thumbOnly);
  }
}

class PhotoHeroState extends State<PhotoHero>
    with AutomaticKeepAliveClientMixin {
  final String thumb;
  final String full;
  final VoidCallback onTap;
  final bool thumbOnly;

  PhotoHeroState({this.thumb, this.full, this.onTap, this.thumbOnly});

  @override
  Widget build(BuildContext context) {
    if (!thumbOnly) {
      timeDilation = 1.0; // 1.0 means normal animation speed.
    }

    return Hero(
      tag: thumb,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: getImage(),
        ),
      ),
    );
  }

  Widget getImage() {
    if (thumbOnly) {
      return CachedNetworkImage(
        placeholder: Image.memory(kTransparentImage),
        imageUrl: thumb,
      );
    } else {
      return new FadeInImage(
        placeholder: NetworkImage(this.thumb),
        image: NetworkImage(this.full),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class HeroAnimation extends StatelessWidget {
  final String thumb;
  final String full;

  const HeroAnimation({Key key, this.thumb, this.full}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoHero(
        thumb: thumb,
        full: full,
        thumbOnly: true,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return Container(
                color: Color(0xFF737373),
                child: Center(
                  widthFactor: 1.0,
                  child: PhotoHero(
                    thumbOnly: false,
                    thumb: thumb,
                    full: full,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ));
          }));
        });
  }
}
