import 'package:flutter/material.dart';

class EntryLabel extends StatelessWidget {
  final String text;
  final Color color;

  const EntryLabel(this.text, {this.color = Colors.black, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: color,
        ),
      ),
    );
  }
}
