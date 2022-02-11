import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/reminder_icon_on_off.dart';
// ignore: unused_import
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/variables/constants.dart';

class ListTileOfWasteNotification extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ListTileOfWasteNotification(
      {this.text = '',
      this.color = Colors.white,
      this.onChanged,
      required this.valueOfSwitch,
      required this.wasteReminderTime,
      required this.wasteSelectedDay});
  final String text;
  final Color color;
  final bool valueOfSwitch;
  final dynamic onChanged;
  final TimeOfDay wasteReminderTime;
  final String wasteSelectedDay;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 6,
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                  shadows: const [
                    Shadow(
                        color: Colors.black12,
                        offset: Offset(0, 0),
                        blurRadius: 15)
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
        ),
        Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconReminderOnOff(isSwitched: valueOfSwitch),
              ],
            )

            /*Container(
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: kDColorWastePlastic,
              ),
              TextNormal(
                  text: 'Plast a nápojový karton\nDrobné kovy',
                  color: kDColorWastePlastic),
              Switch(value: true, onChanged: (value){})
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              top: 0, bottom: 0, left: kDMarginLarger, right: kDMarginLarger),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconReminderOnOff(isSwitched: valueOfSwitch),
              ReminderTimeAndDate(
                  switcher: valueOfSwitch,
                  wasteReminderTime: wasteReminderTime,
                  wasteReminderDay: wasteSelectedDay),
            ],
          ),
        ),*/
            )
      ],
    );
  }
}

/*
return Container(
width: MediaQuery.of(context).size.width * 0.9,

//height: 45,
padding: const EdgeInsets.all(0),
margin: const EdgeInsets.all(2),
decoration: const BoxDecoration(
borderRadius: kDRadius,
color: kDBackgroundColorCalendar,
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
ListTile(
title: Text(
text,
style: TextStyle(
shadows: const [
Shadow(
color: Colors.black12,
offset: Offset(0, 0),
blurRadius: 15)
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
Container(
padding: const EdgeInsets.only(
top: 0, bottom: 0, left: kDMarginLarger, right: kDMarginLarger),
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
IconReminderOnOff(isSwitched: valueOfSwitch),
ReminderTimeAndDate(
switcher: valueOfSwitch,
wasteReminderTime: wasteReminderTime,
wasteReminderDay: wasteSelectedDay),
],
),
),
*/
/*Container(
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: kDColorWastePlastic,
                ),
                TextNormal(
                    text: 'Plast a nápojový karton\nDrobné kovy',
                    color: kDColorWastePlastic),
                Switch(value: true, onChanged: (value){})
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 0, bottom: 0, left: kDMarginLarger, right: kDMarginLarger),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconReminderOnOff(isSwitched: valueOfSwitch),
                ReminderTimeAndDate(
                    switcher: valueOfSwitch,
                    wasteReminderTime: wasteReminderTime,
                    wasteReminderDay: wasteSelectedDay),
              ],
            ),
          ),*/ /*

],
),
);
}
}*/
