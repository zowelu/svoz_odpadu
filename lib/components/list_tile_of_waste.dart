import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/variables/constants.dart';

class ListTileOfWaste extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ListTileOfWaste({this.text, this.date, this.color, this.dayOfWeek});
  final String? text;
  final Color? color;
  final String? date;
  final String? dayOfWeek;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height / 100 * 0.5),
        padding: const EdgeInsets.only(left: kDMargin, right: kDMargin),
        height: MediaQuery.of(context).size.height/100*10,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: kDRadiusSmall,
            color: color),
        child: Row(mainAxisSize: MainAxisSize.max,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                  TextNormal(
                    text: text,
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column( crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextNormal(text: date!),
                  TextNormal(text: dayOfWeek!),
                ],
              ),
            )
          ],
        ));
  }
}
