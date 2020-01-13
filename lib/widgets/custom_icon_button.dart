import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Color color;
  final double size;
  final VoidCallback onTap;
  final IconData icon;
  final double wrapSize;

  const CustomIconButton(
      {Key key,
      this.color: Colors.grey,
      this.size: 50,
      this.onTap,
      this.icon: Icons.add,
      this.wrapSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(size),
        child: SizedBox(
          height: wrapSize,
          width: wrapSize,
          child: Center(
            child: Icon(
              icon,
              color: color,
              size: size,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
