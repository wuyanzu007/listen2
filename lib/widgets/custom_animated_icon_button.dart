import 'package:flutter/material.dart';

class CustomAnimatedIconButton extends StatefulWidget {
  final AnimatedIconData iconData;
  final AnimationController controller;
  final VoidCallback onTap;

  const CustomAnimatedIconButton(
      {Key key, this.iconData, this.controller, this.onTap})
      : super(key: key);

  @override
  _CustomAnimatedIconButtonState createState() =>
      _CustomAnimatedIconButtonState();
}

class _CustomAnimatedIconButtonState extends State<CustomAnimatedIconButton>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = widget.controller == null
        ? AnimationController(duration: const Duration(seconds: 1), vsync: this)
        : widget.controller;
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    if (widget.controller != null) {
      widget.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
      child: Center(
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: animationController,
        ),
      ),
      onTap: () {
        animationController.animateTo(0.0,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        widget.onTap();
      },
    );
  }
}
