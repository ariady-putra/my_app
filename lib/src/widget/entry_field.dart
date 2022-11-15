import 'package:flutter/material.dart';

import 'entry_label.dart';

class EntryField extends StatelessWidget {
  final String text;
  final Color color;
  final bool isPassword;
  final control;
  final validator;
  final textFormatters;
  final TextInputType keyType;

  const EntryField(this.text,
      {this.color = Colors.black,
      this.isPassword = false,
      this.control = 0,
      this.validator = 0,
      this.textFormatters = 0,
      this.keyType = TextInputType.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EntryLabel(
            text,
            color: color,
          ),
          TextFormField(
            obscureText: isPassword,
            keyboardType: keyType,
            inputFormatters: textFormatters == 0 ? [] : textFormatters,
            controller: control == 0 ? TextEditingController() : control,
            validator: validator == 0 ? (_) => null : validator,
            style: TextStyle(color: color),
            decoration: InputDecoration(
              border: InputBorder.none,
              // fillColor: Color(0xFFF3F3F4),
              filled: true,
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
              disabledBorder: border,
              errorStyle: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
