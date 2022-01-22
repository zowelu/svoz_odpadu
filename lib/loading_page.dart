import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/button_settings.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:svoz_odpadu/components/shared_preferences_global.dart';
import 'package:svoz_odpadu/home_page.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  static const id = '/loadingPage';

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  SharedPreferencesGlobal sharedPreferencesGlobal = SharedPreferencesGlobal();

  @override
  void initState() {
    super.initState();
    currentPage = LoadingPage.id;
    sharedPreferencesGlobal.initializePreference().whenComplete(() {
      setState(() {
        sharedPreferencesGlobal.getPreferencesValueCity();
      });
    });
  }

  @override
  void dispose() {
    currentPage = LoadingPage.id;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDBackgroundColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonSettings(
              onTap: () {
                Navigator.pushNamed(context, HomePage.id);
              },
              title: 'Přejít na HomePage',
              subtitle: 'přejít',
              icon: Icons.home),
        ],
      ),
    );
  }
}
