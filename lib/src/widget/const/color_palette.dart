import 'package:flutter/material.dart';

class AppColor {
  // amber
  static const Color lite = Color(0xFFFBB448);
  static const Color deep = Color(0xFFE46B10);
  static const Color dark = Color(0xFFCC600E);
  static const Color darker = Color(0xFFB4550D);
  static const Color darkest = Color(0xFF9D490B);

  // blue
  // static const Color lite = Color(0xFF48B4FB);
  // static const Color deep = Color(0xFF106BE4);
  // static const Color dark = Color(0xFF0E60CC);
  // static const Color darker = Color(0xFF0D55B4);
  // static const Color darkest = Color(0xFF0B499D);
  
  // lime
  // static const Color lite = Color(0xFFB4FB48);
  // static const Color deep = Color(0xFF6BE410);
  // static const Color dark = Color(0xFF60CC0E);
  // static const Color darker = Color(0xFF55B40D);
  // static const Color darkest = Color(0xFFD4990B);
  
  // pink
  // static const Color lite = Color(0xFFFB48B4);
  // static const Color deep = Color(0xFFE4106B);
  // static const Color dark = Color(0xFFCC0E60);
  // static const Color darker = Color(0xFFB40D55);
  // static const Color darkest = Color(0xFF9D0B49);

  static Color buttonHovered1 = lite.withOpacity(.9);
  static Color buttonHovered2 = deep.withOpacity(.9);

  static Color buttonTapped1 = lite.withOpacity(.8);
  static Color buttonTapped2 = deep.withOpacity(.8);

  static Color buttonDisabled1 = Colors.grey.shade400;
  static Color buttonDisabled2 = Colors.grey.shade600;

  static const Color acctType1 = Color(0xF054256F);
  static const Color acctType2 = Color(0xF02EC17A);
  // static const Color acctType3 = Color(0xF0E27144);
  static Color acctType3 = deep.withAlpha(0xF0); // Color(0xF0E46B10);

  static List<ChartScheme> chartScheme = [
    ChartScheme(
      Colors.black,
      Colors.black,
      AppColor.lite.withOpacity(.75),
      AppColor.lite.withOpacity(.75),
      Colors.black,
      Colors.white,
      Colors.black,
      Colors.black,
      Colors.black,
      Colors.black,
      Colors.black,
      AppColor.lite,
      Colors.grey,
    ),
    const ChartScheme(
      Color(0xF02EC17A),
      Color(0xF0E46B10),
      Color(0x7F2EC17A),
      Color(0x7FE46B10),
      Color(0xF02EC17A),
      Colors.white,
      Color(0xF054256F),
      Color(0xF054256F),
      Color(0xF054256F),
      Color(0xF054256F),
      Color(0xF054256F),
      AppColor.lite,
      Colors.grey,
    ),
    ChartScheme(
      Colors.green,
      Colors.red,
      Colors.green.withOpacity(.25),
      Colors.red.withOpacity(.25),
      Colors.green,
      AppColor.lite,
      AppColor.deep,
      AppColor.deep,
      Colors.green,
      Colors.red,
      AppColor.lite,
      AppColor.lite,
      Colors.grey,
    ),
  ];
}

class ChartScheme {
  final Color up;
  final Color down;

  final Color upArea;
  final Color downArea;

  final Color tooltipBg;
  final Color tooltipText;

  final Color axis;
  final Color axisText;

  final Color positiveNumber;
  final Color negativeNumber;
  final Color neutralNumber;

  final Color verticalLines;
  final Color horizontalLines; // not used for now

  const ChartScheme(
    this.up,
    this.down,
    this.upArea,
    this.downArea,
    this.tooltipBg,
    this.tooltipText,
    this.axis,
    this.axisText,
    this.positiveNumber,
    this.negativeNumber,
    this.neutralNumber,
    this.verticalLines,
    this.horizontalLines,
  );
}
