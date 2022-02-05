import 'package:flutter/material.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/divider_menu.dart';

class ListTileOfMenu extends StatelessWidget {
  ListTileOfMenu(
      {Key? key,
      this.fontSize = 14,
      required this.text,
      required this.onTap,
      this.iconSize = 30,
      this.colorOfTile = kDBackgroundColorCalendar})
      : super(key: key);

  final double fontSize;
  final String text;
  final onTap;
  final double iconSize;
  final Color colorOfTile;

  Map<String, IconData> iconByName = {
    'Kalendář': Icons.perm_contact_calendar_outlined,
    'Vybrat město/obec': Icons.location_city_rounded,
    'Nastavení': Icons.settings_rounded,
    'Ohodnotit': Icons.message_outlined,
    'O aplikaci': Icons.info_outline,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: colorOfTile,
          leading: Icon(
            iconByName[text] ?? Icons.web_asset_outlined,
            size: iconSize,
            color: kDBackgroundColor,
          ),
          title: TextHeader(
            text: text,
            color: kDBackgroundColor,
            fontSize: fontSize,
          ),
          onTap: onTap,
        ),
        const DividerMenu(),
      ],
    );
  }
}
