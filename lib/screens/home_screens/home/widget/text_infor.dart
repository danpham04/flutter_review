import 'package:flutter/material.dart';

class TextInfor extends StatelessWidget {
  const TextInfor(
      {super.key,
      this.colorText = Colors.black,
      required this.text,
      this.sizeText});
  final Color? colorText;
  final String text;
  final double? sizeText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(color: colorText, fontSize: sizeText),
      ),
    );
  }
}
