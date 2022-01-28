import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/variables/constants.dart';

class ListTileOfWaste extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ListTileOfWaste(this.text, this.color);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height / 100 * 0.5),
        padding: const EdgeInsets.only(left: kDMargin, right: kDMargin),
        height: MediaQuery.of(context).size.height / 100 * 5,
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: kDRadiusSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.circle,
              color: color,
            ),
            const SizedBox(
              width: 10,
            ),
            TextNormal(
              text: text,
              color: color,
              fontSize: 14,fontWeight: FontWeight.bold,
            ),
          ],
        ));
  }
}
