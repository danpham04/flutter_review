import 'package:flutter/material.dart';

class TabbarHome extends StatefulWidget {
  const TabbarHome({super.key, required this.text, required this.icon, this.colorText = Colors.white, this.colorIcon = Colors.white});
  final String text;
  final IconData icon;
  final Color? colorIcon;
  final Color? colorText;
  
  @override
  State<TabbarHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabbarHome> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(
        widget.icon,
        color: widget.colorIcon,
      ),
      child: Text(
        widget.text,
        style: TextStyle(color: widget.colorText),
      ),
    );
  }
}
