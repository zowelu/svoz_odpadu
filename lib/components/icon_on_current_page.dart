import 'package:flutter/material.dart';

class IconOnCurrentPage extends StatelessWidget {
  const IconOnCurrentPage({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      // ignore: prefer_const_constructors
      icon: icon,
    );
  }
}
