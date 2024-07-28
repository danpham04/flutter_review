import 'package:flutter/material.dart';

class ShowDiaLog extends StatelessWidget {
  const ShowDiaLog(
      {super.key,
      this.color,
      required this.conten,
      required this.title,
      required this.text});
  final Color? color;
  final String conten;
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: color,
      title: Text(title),
      content: Text(conten),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
