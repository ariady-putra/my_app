import 'package:flutter/material.dart';

import '../const/color_palette.dart';
import 'base_button.dart';

class DisabledButton extends StatelessWidget {
  final String label;

  const DisabledButton(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      label,
      gradient1: AppColor.buttonDisabled1,
      gradient2: AppColor.buttonDisabled2,
    );
  }
}
