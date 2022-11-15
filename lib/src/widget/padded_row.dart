import 'dart:math';

import 'package:flutter/material.dart';

import 'entry_label.dart';

class PaddedRow extends StatelessWidget {
  final String label;
  final Widget iconImage;
  final dynamic tapAction;

  const PaddedRow(this.label, this.iconImage, {this.tapAction, super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sW = screenSize.width;
    final sH = screenSize.height;
    final padSize = .01 * min(sW, sH);

    return InkWell(
      onTap: tapAction,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padSize),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 10,
              ),
              child: iconImage,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  EntryLabel(label),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_outlined),
          ],
        ),
      ),
    );
  }
}
