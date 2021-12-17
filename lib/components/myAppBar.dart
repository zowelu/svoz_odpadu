import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Svoz odpadu v Dolních Kounicích', style: TextStyle(fontFamily: kDFontFamilyHeader),),
      centerTitle: true,
      backgroundColor: kDBackgroundColor,
    );
  }
}