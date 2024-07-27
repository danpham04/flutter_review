import 'package:flutter/material.dart';

class TextFileUser extends StatelessWidget {
  const TextFileUser({
    super.key,
    required this.labelText,
    required this.hintText,
    this.onChanged,
    this.textController,
  });
  final String labelText;
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? textController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textController,
        onChanged: onChanged,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            labelText: (labelText),
            hintText: (hintText)),
      ),
    );
  }
}
