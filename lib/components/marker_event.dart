import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class MarkerEvent extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MarkerEvent(this.color, this.dayText);

  final Color color;
  final String dayText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            dayText,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: kDFontFamilyParagraph,
              fontSize: kDFontSizeText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class MarkerEventGradient extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MarkerEventGradient(this.colors, this.dayString);
  final List<Color> colors;

  final String dayString;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.49, 0.5]),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            dayString,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: kDFontFamilyParagraph,
              fontSize: kDFontSizeText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
