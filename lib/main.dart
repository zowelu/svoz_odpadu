import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/about_app_page.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/home_page.dart';
import 'package:svoz_odpadu/loading_page.dart';
import 'package:svoz_odpadu/settings_page.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:svoz_odpadu/components/utilities.dart';


void main() async {
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
        locked: false,
        importance: NotificationImportance.Max,
        soundSource: 'resource://raw/res_custom_notification',
        enableVibration: true,
        channelShowBadge: true,
        ledColor: kDBackgroundColor,
        playSound: true,
      ),
      NotificationChannel(
        channelKey: 'Plast',
        channelName: 'Plast',
        channelDescription: 'plast_channel_description',
        defaultColor: kDBackgroundColor,
        locked: false,
        importance: NotificationImportance.Max,
        soundSource: 'resource://raw/res_custom_notification',
        enableVibration: true,
        channelShowBadge: true,
        ledColor: kDBackgroundColor,
        playSound: true,
      ),
      NotificationChannel(
        channelKey: 'Bioodpad',
        channelName: 'Bioodpad',
        channelDescription: 'bioodpad_channel_description',
        defaultColor: kDBackgroundColor,
        locked: false,
        importance: NotificationImportance.Max,
        soundSource: 'resource://raw/res_custom_notification',
        enableVibration: true,
        channelShowBadge: true,
        ledColor: kDBackgroundColor,
        playSound: true,
      ),
      NotificationChannel(
        channelKey: 'Papír',
        channelName: 'Papír',
        channelDescription: 'papír_channel_description',
        defaultColor: kDBackgroundColor,
        locked: false,
        importance: NotificationImportance.Max,
        soundSource: 'resource://raw/res_custom_notification',
        enableVibration: true,
        channelShowBadge: true,
        ledColor: kDBackgroundColor,
        playSound: true,
      ),
      NotificationChannel(
        channelKey: 'Směsný odpad',
        channelName: 'Směsný odpad',
        channelDescription: 'směsný_odpad_channel_description',
        defaultColor: kDBackgroundColor,
        locked: false,
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
  await getPackageInfo();
  runApp(Phoenix(child: const MyApp()));
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
      home: const LoadingPage(),
      initialRoute: '/',
      routes: {
        HomePage.id: (context) => const HomePage(),
        SettingsPage.id: (context) => const SettingsPage(),
        CityPickerPage.id: (context) => const CityPickerPage(),
        LoadingPage.id: (context) => const LoadingPage(),
        AboutAppPage.id: (context) => const AboutAppPage(),
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
