// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/shared_preferences_global.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';
import 'package:restart_app/restart_app.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class CityPickerPage extends StatefulWidget {
  const CityPickerPage({Key? key}) : super(key: key);
  static const id = '/cityPickerPage';

  @override
  _CityPickerPageState createState() => _CityPickerPageState();
}

class _CityPickerPageState extends State<CityPickerPage> {
  List<String> citiesOfWaste = [
    'Vybrat obec/město',
    'Zowelu Test Town',
    'Dolní Kounice',
  ];
  //String? valueCityPicked;

  SharedPreferencesGlobal sharedPreferencesGlobal = SharedPreferencesGlobal();

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: TextNormal(
        text: item,
        color: kDBackgroundColor,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    currentPage = CityPickerPage.id;
    sharedPreferencesGlobal.initializePreference().whenComplete(() {
      setState(() {
        sharedPreferencesGlobal.getPreferencesValueCity();
      });
    });
  }

  void restartApp(BuildContext context) async {
    if (Platform.isAndroid) {
      Restart.restartApp();
    } else {
      await Phoenix.rebirth(context);
    }
  }

  @override
  void dispose() {
    currentPage = CityPickerPage.id;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: kDBackgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: kDBackgroundColorCalendar,
            width: double.infinity,
            height: kDMyAppBarHeight,
            child: const Center(
              child: TextHeader(
                text: 'Nastavení',
                color: kDBackgroundColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: kDBackgroundColor,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(kDMargin),
                    child: const TextHeader(
                      text: 'Výběr svozového místa',
                      color: kDColorTextColorBackground,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(kDMargin),
                    child: const TextNormal(
                      text:
                          'Pro správnou funkčnost aplikace je nutné zvolit obci/město',
                      color: kDColorTextColorBackground,
                    ),
                  ),
                  const Center(
                    child: TextNormal(
                      text:
                          'pozn.: Po zvolení dojde k restartu aplikace a načtení nových dat.',
                      color: Colors.blueGrey,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 100 * 75,
                        decoration: const BoxDecoration(
                            borderRadius: kDRadius, color: Colors.white),
                        padding: const EdgeInsets.only(
                            top: 9, left: 15, right: 15, bottom: 10),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: valueCityPicked,
                              hint: TextNormal(
                                text: valueCityPicked ?? 'Vyberte obci/město',
                                fontWeight: FontWeight.bold,
                              ),
                              items: citiesOfWaste.map(buildMenuItem).toList(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: kDFontSizeText,
                                  fontFamily: kDFontFamilyParagraph),
                              //dropdownColor: kDBackgroundColor,
                              isExpanded: true,
                              borderRadius: kDRadius,
                              onChanged: (value) {
                                setState(
                                  () {
                                    valueCityPicked = value.toString();
                                    sharedPreferencesGlobal
                                        .setPreferencesValueCity(
                                            valueCityPicked!, 'valueCityPicked')
                                        .whenComplete(() {
                                      print(valueCityPicked);
                                      restartApp(context);
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
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
