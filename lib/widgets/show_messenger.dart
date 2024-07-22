import 'package:flutter/material.dart';

class ShowMessengers {
  static void showMessenger({
    required BuildContext context,
    required String content,
    Color backgroundColor = Colors.black,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(content),
          backgroundColor: backgroundColor,
          duration: duration,
        ),
      );
    }
  }
}
