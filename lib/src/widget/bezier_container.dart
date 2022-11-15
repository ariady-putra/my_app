import 'dart:math';

import 'package:flutter/material.dart';

import 'clipper/bezier_clipper.dart';
import 'const/color_palette.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctxMediaQuery = MediaQuery.of(context);
    final screenSize = ctxMediaQuery.size;
    final sW = screenSize.width;
    final sH = screenSize.height;

    return Transform.translate(
      offset: Offset(-sW * .215, 0),
      child: Transform.rotate(
        angle: -pi / 3.5,
        child: ClipPath(
          clipper: ClipPainter(),
          child: Container(
            height: sH * .5,
            width: sW,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.lite,
                  AppColor.deep,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
