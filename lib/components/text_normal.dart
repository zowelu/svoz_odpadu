import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class TextNormal extends StatelessWidget {
  const TextNormal({Key? key, required this.text, this.color = Colors.white, this.fontWeight = FontWeight.normal, this.fontSize = kDFontSizeText}) : super(key: key);

  final String? text;
  final Color? color;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: kDFontFamilyParagraph,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}