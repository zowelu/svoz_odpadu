import 'package:flutter/material.dart';
import 'package:svoz_odpadu/variables/constants.dart';

class IconReminderOnOff extends StatelessWidget {
  const IconReminderOnOff({
    Key? key,
    required this.isSwitched,
  }) : super(key: key);

  final bool isSwitched;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: isSwitched
          ? const Icon(
        Icons.notifications_active,
        color: kDBackgroundColor,
        size: 30,
      )
          : const Icon(
        Icons.notifications_off,
        color: Colors.grey,
        size: 30,
      ),
    );
  }
}