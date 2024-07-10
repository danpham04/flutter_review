import 'package:flutter/material.dart';

class TabIcon extends StatelessWidget {
  const TabIcon({super.key, required this.icon,this.colorIcon = Colors.white, this.iconSize,});
  final Widget icon;
  final Color? colorIcon;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: icon, 
        color: colorIcon,);
  }
}
