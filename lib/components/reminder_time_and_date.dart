import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/variables/constants.dart';

class ReminderTimeAndDate extends StatelessWidget {
  const ReminderTimeAndDate(
      {Key? key,
      required this.switcher,
      required this.wasteReminderTime,
      required this.wasteReminderDay})
      : super(key: key);
  final bool switcher;
  final TimeOfDay? wasteReminderTime;
  final String? wasteReminderDay;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Column(
        children: [
          TextNormal(
            text: switcher ? wasteReminderDay! : '',
            color: kDBackgroundColor,
            fontSize: 14,
          ),
          Center(
            child: TextNormal(
              fontSize: 14,
              color: kDBackgroundColor,
              fontWeight: FontWeight.bold,
              text: switcher
                  ? '${wasteReminderTime?.hour.toString()} : ${wasteReminderTime?.minute.toString()}'
                  : 'Nenastaveno',
            ),
          )
        ],
      ),
    );
  }
}
