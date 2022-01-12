import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class TextHeader extends StatelessWidget {
  const TextHeader({Key? key, required this.text, this.color = kDBackgroundColor}) : super(key: key);

  final String? text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: kDFontSizeHeader,
        fontFamily: kDFontFamilyHeader,
        color: color,
      ),
    );
  }
}