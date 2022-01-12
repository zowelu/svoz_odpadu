import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/text_normal.dart';

class ReminderTimeAndDate extends StatelessWidget {
  const ReminderTimeAndDate({
    Key? key, required this.switcher, required this.wasteReminderTime, required this.wasteReminderDay
  }) : super(key: key);
  final bool switcher;
  final TimeOfDay? wasteReminderTime;
  final String? wasteReminderDay;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      fit: FlexFit.loose,
      child: Column(
        children: [
          Text(
            wasteReminderDay!,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Center(
            child: TextNormal(
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