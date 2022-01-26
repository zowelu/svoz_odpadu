import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/variables/constants.dart';

class ListTileOfWaste extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ListTileOfWaste(this.text, this.color);
  final String text;
  final Color color;

/*  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width / 100 * 75,

      child: ListTile(
        title: TextNormal(
          text: text,
          color: color,
          fontSize: 14,
          lineHeight: 0.5,
        ),
        leading: Icon(Icons.circle, color: color),
        dense: true,
        horizontalTitleGap: 0.0,
        minVerticalPadding: 0.0,
        style: ListTileStyle.list,
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height / 100 * 0.5),
        padding: const EdgeInsets.only(left: kDMargin, right: kDMargin),
        height: MediaQuery.of(context).size.height / 100 * 5,
        decoration: const BoxDecoration(
            color: kDBackgroundColorCalendar,
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
              fontSize: 14,
            ),
          ],
        ));
  }
}
