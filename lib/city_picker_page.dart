// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svoz_odpadu/components/button_settings.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/home_page.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

class CityPickerPage extends StatefulWidget {
  const CityPickerPage({Key? key}) : super(key: key);
  static const id = '/cityPickerPage';

  @override
  _CityPickerPageState createState() => _CityPickerPageState();
}

class _CityPickerPageState extends State<CityPickerPage> {
  List<String> citiesOfWaste = [
    'Vybrat obec/město',
    'Dolní Kounice',
    'Ivančice'
  ];
  String? valueCityPicked;
  SharedPreferences? preferences;

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> getPreferencesValueCity() async {
    setState(() {
      valueCityPicked =
          preferences!.getString('valueCityPicked') ?? 'Vybrat obec/město';

      if (valueCityPicked == 'Vybrat obec/město') {
        valueCityPickedGlobal = false;
      }
      if (valueCityPicked != 'Vybrat obec/město') {
        valueCityPickedGlobal = true;
        print(valueCityPickedGlobal);
      }
    });
    print('get preferences value: $valueCityPicked');
  }

  Future<void> setPreferencesValueCity() async {
    setState(() {
      preferences!.setString('valueCityPicked', valueCityPicked!);
    });
  }

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
    initializePreference().whenComplete(() {
      setState(() {
        getPreferencesValueCity();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kDMyAppBarHeight),
        child: MyAppBar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
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
          ),
          Flexible(
            flex: 20,
            fit: FlexFit.tight,
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
                              text: valueCityPicked ?? 'Vyberte obci/město', fontWeight: FontWeight.bold,),
                          items: citiesOfWaste.map(buildMenuItem).toList(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: kDFontSizeText,
                              fontFamily: kDFontFamilyParagraph),
                          //dropdownColor: kDBackgroundColor,
                          isExpanded: true,
                          borderRadius: kDRadius,
                          onChanged: (value) => setState(
                            () {
                              valueCityPicked = value.toString();
                              setPreferencesValueCity();
                              print(valueCityPicked);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  ButtonSettings(
                      onTap: () {
                        Navigator.pushNamed(context, HomePage.id);
                      },
                      title: 'Přejít na Home Page',
                      subtitle: '',
                      icon: Icons.arrow_forward_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
