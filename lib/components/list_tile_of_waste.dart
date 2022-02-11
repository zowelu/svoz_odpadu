import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/variables/constants.dart';

class ListTileOfWaste extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ListTileOfWaste({this.text, this.date, this.color, this.dayOfWeek, this.asset});
  final String? text;
  final Color? color;
  final String? date;
  final String? dayOfWeek;
  final String? asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.height / 100 * 0.5),
      padding: const EdgeInsets.only(
          left: kDMargin, right: kDMargin, top: kDMargin, bottom: kDMargin),
      //height: MediaQuery.of(context).size.height / 100 * 10,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle, borderRadius: kDRadiusSmall, color: color),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 0, bottom: kDMargin),
                  child: Image.asset(
                    asset!,
                    width: 60.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextHeader(
                  text: text,
                  color: Colors.white,
                  fontSize: 20,
                ),SizedBox(height: MediaQuery.of(context).size.height/100*1,),
                TextNormal(text: date!),
                TextNormal(text: dayOfWeek!,fontWeight: FontWeight.bold,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
