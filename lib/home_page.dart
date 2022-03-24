// ignore_for_file: avoid_print

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svoz_odpadu/calendar_page.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/list_of_waste_page.dart';
import 'package:svoz_odpadu/settings_page.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends StatefulWidget {
  static const id = '/homePage';

  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    currentPage = HomePage.id;
  }

  @override
  void dispose() {
    currentPage = HomePage.id;
    super.dispose();
  }

  int currentIndex = 0;
  final screens = [
    const CalendarPage(),
    //const HomePage(),
    const ListOfWastePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('cs');
    return WillPopScope(
        onWillPop: () async {
          try {
            await showFlash(
              context: context,
              builder: (context, controller) {
                return Flash.dialog(
                  controller: controller,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: FlashBar(
                    content: const Center(
                      child: TextNormal(
                        text: 'Chcete opustit aplikaci?',
                        color: kDBackgroundColor,
                      ),
                    ),
                    title: const Center(
                      child: TextHeader(
                        text: 'Opuštíte aplikaci',
                        color: kDBackgroundColor,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {

                        },
                        child: const TextNormal(
                          text: 'Ne',
                          color: kDBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          //Navigator.of(context).pop();
                          controller.dismiss();
                          controller.onWillPop;
                          SystemNavigator.pop(animated: true);
                        },
                        child: const TextNormal(
                          text: 'Ano',
                          color: kDBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
            return true;
          } catch (e) {
            print(e);
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: kDBackgroundColor,
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(kDMyAppBarHeight),
              child: MyAppBar()),
          //drawer: const DrawerMenu(),
          //floatingActionButton: fabHome,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            //showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            backgroundColor: kDBackgroundColorCalendar,
            unselectedItemColor: Colors.black54,
            selectedItemColor: kDBackgroundColor, selectedFontSize: 16,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined), label: 'Kalendář'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_outlined), label: 'Nejbližší svozy'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: 'Nastavení'),
            ],
          ),
          body: screens[currentIndex],
        ));
  }
}
