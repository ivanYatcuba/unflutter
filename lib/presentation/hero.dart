import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {Key key, this.thumb, this.full, this.onTap, this.width, this.thumbOnly})
      : super(key: key);

  final String thumb;
  final String full;
  final VoidCallback onTap;
  final double width;

  final bool thumbOnly;

  Widget build(BuildContext context) {
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
      return new FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: thumb,
      );
    } else {
      return new FadeInImage(
        placeholder: NetworkImage(this.thumb),
        image: NetworkImage(this.full),
      );
    }
  }
}

class HeroAnimation extends StatelessWidget {
  final String thumb;
  final String full;

  const HeroAnimation({Key key, this.thumb, this.full}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 means normal animation speed.

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
