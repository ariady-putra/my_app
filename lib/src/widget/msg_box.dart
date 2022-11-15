import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/src/widget/text_formatter.dart';

import 'button/default_button.dart';
import 'entry_field.dart';

enum DialogIcon { error, warn, info, ask, none }

class MsgBox {
  static showSimpleTextInputDialog(
    BuildContext context,
    String label,
    TextEditingController controller, {
    dynamic okAction = 0,
    dynamic keyType,
    dynamic textFormatters,
  }) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: EntryField(
                label,
                control: controller,
                keyType: keyType ?? TextInputType.text,
                textFormatters: textFormatters,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: DefaultButton(
                'OK',
                tapAction:
                    okAction == 0 ? () => Navigator.pop(context) : okAction,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showSimpleNumberInputDialog(
      BuildContext context, String label, TextEditingController controller,
      {dynamic okAction = 0}) {
    return showSimpleTextInputDialog(
      context,
      label,
      controller,
      keyType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      textFormatters: [
        TextFormatter.numbersOnly,
      ],
    );
  }

  static showAlertDialogOK(
    BuildContext context,
    DialogIcon iconType,
    String importantText, {
    TextStyle importantStyle = const TextStyle(fontWeight: FontWeight.bold),
    Color foreColor = Colors.black,
    String prefix = '',
    String postfix = '',
    dynamic okAction = 0,
  }) {
    dynamic icon;
    switch (iconType) {
      case DialogIcon.error:
        icon = const Icon(
          Icons.error_outline_outlined,
          color: Colors.red,
        );
        break;

      case DialogIcon.warn:
        icon = const Icon(
          Icons.warning_outlined,
          color: Colors.amber,
        );
        break;

      case DialogIcon.info:
        icon = const Icon(
          Icons.info_outlined,
          color: Colors.blue,
        );
        break;

      case DialogIcon.ask:
        icon = const Icon(
          Icons.question_mark_outlined,
          color: Colors.green,
        );
        break;

      default:
        break;
    }

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: icon,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: foreColor),
                  children: [
                    TextSpan(text: prefix),
                    TextSpan(
                      text: ' $importantText ',
                      style: importantStyle,
                    ),
                    TextSpan(text: postfix),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          DefaultButton(
            'OK',
            tapAction: okAction == 0 ? () => Navigator.pop(context) : okAction,
          ),
        ],
      ),
    );
  }
}
