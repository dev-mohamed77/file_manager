import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;
  final Color color;
  final Alignment alignment;

  const CustomAppBar({
    Key? key,
    required this.child,
    required this.color,
    this.alignment = Alignment.center,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: alignment,
      child: child,
    );
  }
}
