import 'package:flutter/material.dart';

import '../const/color_palette.dart';

class BaseButton extends StatelessWidget {
  final String label;
  final Color gradient1;
  final Color gradient2;

  const BaseButton(
    this.label, {
    this.gradient1 = AppColor.lite,
    this.gradient2 = AppColor.deep,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            // offset: const Offset(2, 4),
            // blurRadius: 2,
            spreadRadius: 2,
            blurStyle: BlurStyle.solid,
          ),
        ],
        gradient: LinearGradient(
          // begin: Alignment.centerLeft,
          // end: Alignment.centerRight,
          colors: [
            gradient1,
            gradient2,
          ],
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
