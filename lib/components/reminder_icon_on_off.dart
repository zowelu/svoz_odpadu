import 'package:flutter/material.dart';

class IconReminderOnOff extends StatelessWidget {
  const IconReminderOnOff({
    Key? key,
    required this.isSwitchedPlastic,
  }) : super(key: key);

  final bool isSwitchedPlastic;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: isSwitchedPlastic
          ? const Icon(
        Icons.notifications_active,
        color: Colors.white,
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