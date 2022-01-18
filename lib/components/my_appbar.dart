import 'package:flutter/material.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/home_page.dart';
import 'package:svoz_odpadu/settings_page.dart';
import 'package:svoz_odpadu/components/icon_on_current_page.dart';
import 'package:svoz_odpadu/components/about_app_dialog.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: kDBackgroundColor,
      actions: [
        (currentPage == SettingsPage.id || currentPage == CityPickerPage.id)
            ? IconOnCurrentPage(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AboutAppDialog();
                    },
                  );
                },
                icon: const Icon(Icons.info),
              )
            : IconOnCurrentPage(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              )
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
                    fontSize: 18,
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
