import 'package:flutter/material.dart';
import 'package:svoz_odpadu/about_app_page.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/components/button_settings.dart';
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // decoration: const BoxDecoration(boxShadow: [
                    //   BoxShadow(
                    //     color: kDBoxShadowColor,
                    //     offset: Offset(2, 0),
                    //     blurRadius: 10,
                    //   ),
                    // ]),
                    child: DrawerHeader(
                      decoration: const BoxDecoration(color: kDBackgroundColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/images/app_icon.png',
                            height: 100,
                          ),
                          const TextHeader(
                            text: 'Svoz odpadu',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      children: [
                        Image.asset('assets/images/DK_znak_800px.png',
                            width: 60),
                        TextHeader(
                          text: 'Dolní Kounice',
                          color: kDBackgroundColor,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(
                                context, CityPickerPage.id);
                          },
                          child: Text(
                            'Vybrat jiné město',
                            style: TextStyle(
                                fontFamily: kDFontFamilyHeader,
                                color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: kDBackgroundColor),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
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
                            text: 'Nastavení',
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, SettingsPage.id);
                            },
                          ),
                          ListTileOfMenu(
                            text: 'Ohodnotit',
                            onTap: () async {
                              //po stisknutí otevře stránku v externím prohlížeči
                              OpenUrlInBrowser()
                                  .openUrl('https://play.google.com/store/apps/details?id=cz.zowelu.svoz_odpadu&hl=cs');
                            },
                          ),
                          ListTileOfMenu(
                            text: 'O aplikaci',
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, AboutAppPage.id);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  /*Container(
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
                    ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
