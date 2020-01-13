import 'package:flutter/material.dart';

class HorizontalPlaceholder extends StatelessWidget {
  final double width;

  const HorizontalPlaceholder(this.width, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class VerticalPlaceholder extends StatelessWidget {
  final double height;

  const VerticalPlaceholder(this.height, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
