import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class TextNormal extends StatelessWidget {
  const TextNormal({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String? text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: const TextStyle(
        fontSize: kDFontSizeText,
        fontFamily: kDFontFamilyParagraph,
        color: kDBackgroundColor,
      ),
    );
  }
}