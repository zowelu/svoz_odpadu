import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class ListTileOfWaste extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ListTileOfWaste(this.text, this.color);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        borderRadius: kDRadius,
        color: Colors.white54,
      ),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(shadows: const [Shadow(color: Colors.black12,
            offset: Offset(0, 0),
            blurRadius: 15)],
              fontFamily: kDFontFamilyParagraph, fontSize: 16, color: color, fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.circle, color: color),
        dense: true,
        horizontalTitleGap: 0.0,
        minVerticalPadding: 0.0,
        style: ListTileStyle.list,
      ),
    );
  }
}
