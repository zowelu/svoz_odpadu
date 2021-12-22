import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class TextHeader extends StatelessWidget {
  const TextHeader({
    Key? key, required this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: const TextStyle(
        fontSize: kDFontSizeHeader,
        fontFamily: kDFontFamilyHeader,
        color: kDBackgroundColor,
      ),
    );
  }
}