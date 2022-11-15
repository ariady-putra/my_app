import 'package:flutter/material.dart';
import 'package:my_app/src/widget/button/base_button.dart';

import '../const/color_palette.dart';

class ActionButton extends StatefulWidget {
  final String label;
  final dynamic tapAction;

  const ActionButton(this.label, this.tapAction, {super.key});

  @override
  State<ActionButton> createState() => _ActionButtonState(label, tapAction);
}

class _ActionButtonState extends State<ActionButton> {
  final String label;
  final dynamic tapAction;

  _ActionButtonState(this.label, this.tapAction);

  bool isTapped = false;
  bool isHovered = false;

  /* Order of priority from highest to lowest:
   - tapped
   - hovered
  */

  Color get gradient1 {
    if (isTapped) return AppColor.buttonTapped1;
    if (isHovered) return AppColor.buttonHovered1;
    return AppColor.lite;
  }

  Color get gradient2 {
    if (isTapped) return AppColor.buttonTapped2;
    if (isHovered) return AppColor.buttonHovered2;
    return AppColor.deep;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapAction,
      onTapDown: (details) => setState(
        () {
          isTapped = true;
        },
      ),
      onTapUp: (details) => setState(
        () {
          isTapped = false;
        },
      ),
      onTapCancel: () => setState(
        () {
          isTapped = false;
        },
      ),
      onHover: (value) => setState(
        () {
          isHovered = value;
        },
      ),
      child: BaseButton(
        label,
        gradient1: gradient1,
        gradient2: gradient2,
      ),
    );
  }
}
