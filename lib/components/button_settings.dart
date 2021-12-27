import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class ButtonSettings extends StatelessWidget {
  const ButtonSettings(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.subtitle, required this.icon})
      : super(key: key);

  final onTap;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDMargin),
      child: InkWell(
        onTap: onTap,
        child: Container(
            decoration:  BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: kDRadiusLarge,
              color: kDBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width / 100 * 80,
            child: ListTile(
              subtitle: Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: kDFontFamilyParagraph,
                  fontSize: 14,
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(
                    fontSize: kDFontSizeHeader,
                    color: Colors.white,
                    fontFamily: kDFontFamilyParagraph,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                icon,
                color: Colors.white,
                size: 35,
              ),
            ),),
      ),
    );
  }
}
