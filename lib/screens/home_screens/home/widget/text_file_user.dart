import 'package:flutter/material.dart';

class TextFileUser extends StatefulWidget {
  const TextFileUser(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.onChanged, this.textController});
  final String labelText;
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? textController;
  @override
  State<TextFileUser> createState() => _TextFileUserState();
}

class _TextFileUserState extends State<TextFileUser> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: (widget.labelText),
          hintText: (widget.hintText)),
    );
  }
}
