import 'package:flutter/material.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: kDBackgroundColor,
      //bottom: PreferredSize(child: TextWidget(), preferredSize: Size.fromHeight(4.0)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/DK_znak_200px.png',
            width: 50,
          ),
          Text(
            'Město Dolní Kounice',
            style: TextStyle(
                fontFamily: kDFontFamilyHeader,
                fontSize: 18,
                color: kDColorTextColorBackground),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, CityPickerPage.id);
              },
              child: Text('Vybrat jiné'))
        ],
      ),
    );
  }
}
