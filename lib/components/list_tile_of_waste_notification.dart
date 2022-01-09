import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class ListTileOfWasteNotification extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ListTileOfWasteNotification(this.text, this.color, this.onChanged,
      {this.valueOfSwitch = false});
  final String text;
  final Color color;
  final bool valueOfSwitch;
  final dynamic onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/100*80,
      height: 45,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        borderRadius: kDRadius,
        color: kDBackgroundColorCalendar,
      ),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
              shadows: const [
                Shadow(
                    color: Colors.black12, offset: Offset(0, 0), blurRadius: 15)
              ],
              fontFamily: kDFontFamilyParagraph,
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.circle, color: color),
        dense: true,
        horizontalTitleGap: 0.0,
        minVerticalPadding: 0.0,
        style: ListTileStyle.list,
        trailing: Switch(
          value: valueOfSwitch,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
