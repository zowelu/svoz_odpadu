import 'package:flutter/material.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/divider_menu.dart';

class ListTileOfMenu extends StatelessWidget {
  const ListTileOfMenu({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.perm_contact_calendar_outlined,
            size: 30,
            color: kDBackgroundColor,
          ),
          title: TextHeader(
            text: 'Kalendář',
            color: kDBackgroundColor,
            fontSize: fontSize,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        DividerMenu(),
      ],
    );
  }
}