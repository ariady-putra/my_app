import 'package:flutter/material.dart';

class PrevButton extends StatelessWidget {
  final String label;
  final tapAction;

  const PrevButton({this.label = 'Back', this.tapAction = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapAction == 0 ? () => Navigator.pop(context) : tapAction,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: const Icon(Icons.chevron_left_outlined),
            ),
            RichText(
              text: TextSpan(
                text: label,
                style: const TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
