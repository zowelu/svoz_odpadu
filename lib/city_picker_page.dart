import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class CityPickerPage extends StatefulWidget {
  const CityPickerPage({Key? key}) : super(key: key);
  static const id = '/cityPickerPage';

  @override
  _CityPickerPageState createState() => _CityPickerPageState();
}

class _CityPickerPageState extends State<CityPickerPage> {
  List<String> citiesOfWaste = ['Dolní Kounice', 'Ivančice'];
  String? value;

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: TextNormal(
        text: item,
      ),
    );
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
                    DropdownButton(
                        items: citiesOfWaste.map(buildMenuItem).toList(),style: TextStyle(color: kDBackgroundColor),
                        onChanged: (value) => setState(() {
                          this.value = value.toString();
                        }))],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
