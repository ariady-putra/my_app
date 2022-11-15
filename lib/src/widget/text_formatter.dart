import 'package:flutter/services.dart';

class TextFormatter {
  static TextInputFormatter numbersOnly = FilteringTextInputFormatter.allow(
    RegExp(r'[0-9]'),
  );
}
