import 'package:flutter/material.dart';

import 'const/color_palette.dart';

class PageTitle extends StatelessWidget {
  final String firstHalf;
  final String secondHalf;
  final Color firstColor;
  final Color secondColor;
  final bool glow;

  const PageTitle(this.firstHalf, this.secondHalf,
      {this.firstColor = Colors.black,
      this.secondColor = AppColor.deep,
      this.glow = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
        children: [
          TextSpan(
            text: firstHalf,
            style: TextStyle(
              color: firstColor,
              shadows: !glow
                  ? []
                  : [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.white.withOpacity(.8),
                        offset: const Offset(1, 1),
                      ),
                    ],
            ),
          ),
          TextSpan(
            text: secondHalf,
            style: TextStyle(
              color: secondColor,
              shadows: !glow
                  ? []
                  : [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.white.withOpacity(.9),
                        offset: const Offset(1, 1),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}
