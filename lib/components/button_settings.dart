import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';

import 'package:svoz_odpadu/variables/constants.dart';

class ButtonSettings extends StatelessWidget {
  const ButtonSettings(
      {Key? key,
      required this.onTap,
      required this.title,
      this.subtitle = '',
      required this.icon,
      this.color = kDBackgroundColor})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kDMargin),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: kDRadiusLarge,
            color: color,
            boxShadow: const [
              BoxShadow(
                color: kDBoxShadowColor,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width / 100 * 80,
          child: ListTile(
            subtitle: TextNormal(
              text: subtitle,
              fontSize: 14,
            ),
            title: TextHeader(
              text: title,
            ),
            leading: Icon(
              icon,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}
