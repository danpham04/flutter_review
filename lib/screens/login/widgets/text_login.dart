import 'package:flutter/material.dart';

class TextLogin extends StatelessWidget {
  const TextLogin(
      {super.key,
      required this.text,
      this.colorText,
      this.sizeText,
      this.fontText});
  final String text;
  final Color? colorText;
  final double? sizeText;
  final FontWeight? fontText;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: colorText,
        fontSize: sizeText,
        fontWeight: fontText,
      ),
    );
  }
}
