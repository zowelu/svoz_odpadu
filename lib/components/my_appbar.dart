import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/settings_page.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: kDBackgroundColor,
      actions: [
        IconButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),),),
          // ignore: prefer_const_constructors
          icon: Icon(Icons.settings),
        ),
      ],
      //bottom: PreferredSize(child: TextWidget(), preferredSize: Size.fromHeight(4.0)),
      title: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          children: [
            WidgetSpan(
              child: Text(
                'KALENDÁŘ SVOZU ODPADU',
                style: TextStyle(
                    fontFamily: kDFontFamilyHeader,
                    fontSize: 20,
                    color: kDColorTextColorBackground),
              ),
            ),
            WidgetSpan(
              child: Text(
                'Město Dolní Kounice',
                style: TextStyle(
                    fontFamily: kDFontFamilyHeader,
                    fontSize: 13,
                    color: kDColorTextColorBackground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
