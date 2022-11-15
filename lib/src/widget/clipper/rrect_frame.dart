import 'package:flutter/material.dart';

class RRectFrame extends CustomClipper<Path> {
  final double radius;

  RRectFrame(this.radius);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.fillType = PathFillType.nonZero;
    path.addRRect(
      RRect.fromLTRBXY(0, 0, size.width, size.height, radius, radius),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
