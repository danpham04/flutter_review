import 'package:flutter/material.dart';

class ShowDiaLog extends StatelessWidget {
  const ShowDiaLog(
      {super.key,
      this.color,
      required this.content,
      required this.title,
       this.actions, });
  final Color? color;
  final String content;
  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: color,
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }
}
