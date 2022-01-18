import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/constants/global_var.dart';

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
    this.preferences = await SharedPreferences.getInstance();
  }

  Future<void> getPreferencesValue() async {
    setState(() {
      valueCityPicked = preferences!.getString('valueCityPicked') ?? 'Vybrat obec/město';
    });
    print('get preferences value: $valueCityPicked');
  }

  Future<void> setPreferencesValue() async {
    setState(() {
      this.preferences!.setString('valueCityPicked', valueCityPicked!);
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
    currentPage = 'city_picker_page';
    initializePreference().whenComplete(() {
      setState(() {
        getPreferencesValue();
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
      body: Container(
        //padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 100 * 2),
        child: Column(
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
                      decoration: BoxDecoration(
                          borderRadius: kDRadius, color: Colors.white),
                      padding: EdgeInsets.only(
                          top: 9, left: 15, right: 15, bottom: 10),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: valueCityPicked,
                            hint:
                                TextNormal(text: valueCityPicked ?? 'Vyberte obci/město'),
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
                                this.valueCityPicked = value.toString();
                                setPreferencesValue();
                                print(valueCityPicked);
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
