import 'package:flutter/material.dart';

import 'action_button.dart';
import 'disabled_button.dart';

class DefaultButton extends StatelessWidget {
  final String label;
  final dynamic tapAction;
  final bool disabled;

  const DefaultButton(
    this.label, {
    this.tapAction,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return disabled ? DisabledButton(label) : ActionButton(label, tapAction);
  }
}
