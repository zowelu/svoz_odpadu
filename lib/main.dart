import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/home_page.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/components/global_var.dart';
import 'package:svoz_odpadu/settings_page.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'basic_channel_description',
        defaultColor: kDBackgroundColor,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        enableVibration: true,
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        channelDescription: 'scheduled_channel_description',
        defaultColor: kDBackgroundColor,
        locked: true,
        importance: NotificationImportance.Max,
        soundSource: 'resource://raw/res_custom_notification',
        enableVibration: true,
        channelShowBadge: true,
        ledColor: kDBackgroundColor,
        playSound: true,
      ),
    ],
  );
  currentPage = 'main';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: EasySplashScreen(
        logo: Image.asset('assets/images/app_icon.png'),
        logoSize: 200,
        title: const Text(
          'Kalendář svozu odpadu',
          style: TextStyle(
              fontFamily: kDFontFamilyHeader,
              fontSize: kDFontSizeHeader,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: kDBackgroundColor,
        durationInSeconds: 5,
        loaderColor: Colors.white,
        showLoader: true,
        loadingText: const Text(
          'Načítám...',
          style: TextStyle(
              color: Colors.white,
              fontFamily: kDFontFamilyParagraph,
              fontSize: kDFontSizeText),
        ),
        navigator: const HomePage(),
      ),
      initialRoute: '/',
      routes: {
        HomePage.id: (context) => const HomePage(),
        SettingsPage.id: (context) => const SettingsPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kDMyAppBarHeight), child: MyAppBar()),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomePage.id);
              },
              child: const Text('Pokračujte na kalendář'),
            ),
          ],
        ),
      ),
    );
  }
}
