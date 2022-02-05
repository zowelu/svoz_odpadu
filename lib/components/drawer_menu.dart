import 'package:flutter/material.dart';
import 'package:svoz_odpadu/about_app_page.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/components/divider_menu.dart';
import 'package:svoz_odpadu/components/list_tile_of_menu.dart';
import 'package:svoz_odpadu/components/open_url_in_browser.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/settings_page.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kDBackgroundColorCalendar,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: kDBoxShadowColor,
                      offset: Offset(2, 0),
                      blurRadius: 10,
                    ),
                  ]),
                  child: DrawerHeader(
                    decoration: const BoxDecoration(color: kDBackgroundColor),
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/app_icon.png',
                          height: 60,
                        ),
                        const TextHeader(
                          text: 'Svoz odpadu',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: kDBackgroundColor,
                      //borderRadius: kDRadiusLarge,
                      boxShadow: [
                        BoxShadow(
                            color: kDBoxShadowColor,
                            offset: Offset(2, 2),
                            blurRadius: 10,
                            spreadRadius: 2),
                      ]),
                  child: Column(
                    children: [
                      ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 40),
                          child: Image.asset(
                            'assets/images/DK_znak_200px.png',
                          )),
                      const TextHeader(
                        text: 'Město Dolní Kounice',
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const DividerMenu(),
                    ListTileOfMenu(
                        text: 'Kalendář',

                        onTap: () {
                          Navigator.of(context).pop();
                        }),
                    ListTileOfMenu(

                        text: 'Vybrat město/obec',
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, CityPickerPage.id);
                        }),
                    ListTileOfMenu(
                      text: 'Nastavení',
                      onTap: () {
                        Navigator.popAndPushNamed(context, SettingsPage.id);
                      },
                    ),
                    ListTileOfMenu(
                      text: 'Ohodnotit',
                      onTap: () {},
                    ),
                    ListTileOfMenu(
                      text: 'O aplikaci',
                      onTap: () {
                        Navigator.popAndPushNamed(context, AboutAppPage.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              decoration:
              const BoxDecoration(color: kDBackgroundColor, boxShadow: [
                BoxShadow(
                    color: kDBoxShadowColor,
                    offset: Offset(2, 2),
                    blurRadius: 10,
                    spreadRadius: 2),
              ]),
              padding: const EdgeInsets.only(
                  left: kDMargin, right: kDMargin, bottom: kDMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextNormal(
                    text: 'verze: $appVersion',
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            OpenUrlInBrowser()
                                .openUrl('https://www.webstrong.cz');
                          },
                          child: Image.asset(
                            'assets/images/webstrong-logo.png',
                          ),
                        ),
                      ),
                      const Flexible(
                        flex: 1,
                        child: SizedBox(
                          width: 30,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            OpenUrlInBrowser()
                                .openUrl('https://www.zowelu.cz');
                          },
                          child: Image.asset(
                            'assets/images/zowelu_logo.png',
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
