import 'package:flutter/material.dart';
import 'package:svoz_odpadu/variables/constants.dart';

class TextNormal extends StatelessWidget {
  const TextNormal({Key? key, required this.text, this.color = Colors.white, this.fontWeight = FontWeight.normal, this.fontSize = kDFontSizeText, this.lineHeight = 1}) : super(key: key);

  final String? text;
  final Color? color;
  final FontWeight fontWeight;
  final double fontSize;
  final double lineHeight;

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