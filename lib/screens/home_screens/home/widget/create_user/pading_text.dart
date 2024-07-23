import 'package:flutter/material.dart';
import 'package:flutter_review/screens/home_screens/home/widget/text_file_user.dart';

class PadingText extends StatelessWidget {
  const PadingText(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.onChanged,
      this.textController});
  final String labelText;
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? textController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFileUser(
        textController: textController,
        labelText: labelText,
        hintText: hintText,
        onChanged: (value) {
          onChanged;
        },
      ),
    );
  }
}
