import 'package:flutter/material.dart';

class ButtonDigLog extends StatelessWidget {
  const ButtonDigLog(
      {super.key, required this.text, this.onPressed, this.style, this.color});

  final String text;
  final void Function()? onPressed;
  final ButtonStyle? style;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}
