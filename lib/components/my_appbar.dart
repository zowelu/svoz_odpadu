import 'package:flutter/material.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/components/text_header.dart';
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
            valueCityPickedPath ?? 'assets/images/app_icon.png',
            width: 50,
          ),
          TextHeader(
            text: valueCityPicked ?? 'Nevybráno město',
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, CityPickerPage.id);
            },
            child: const Text('Vybrat jiné'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                kDBackgroundColorCalendar,
              ),
              foregroundColor: MaterialStateProperty.all(
                kDBackgroundColor,
              ),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: kDRadius,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
