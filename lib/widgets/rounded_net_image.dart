import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class RoundedNetImage extends StatelessWidget {
  final String url;
  final double radius;
  final double width;
  final double height;
  final BoxFit fit;

  RoundedNetImage(this.url,
      {this.width: 200,
      this.height: 200,
      this.radius: 0.0,
      this.fit: BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: ExtendedImage.network(
          url,
          cache: true,
          fit: fit,
        ),
      ),
    );
  }
}
