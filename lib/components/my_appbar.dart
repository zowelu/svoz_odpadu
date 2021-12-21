import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Svoz odpadu v Dolních Kounicích',
        style: TextStyle(
            fontFamily: kDFontFamilyHeader,
            fontSize: kDFontSizeHeader,
            color: kDColorTextColorBackground),
      ),
      centerTitle: true,
      backgroundColor: kDBackgroundColor,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.0),child: Container( width: 50,child: InkWell(onTap: (){}, child: Icon(Icons.settings, ),)),
        ),
      ],
    );
  }
}
