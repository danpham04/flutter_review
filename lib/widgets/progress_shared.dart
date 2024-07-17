import 'package:flutter/material.dart';

class ProgressShared extends StatelessWidget {
  const ProgressShared({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
