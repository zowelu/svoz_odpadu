import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/calendar_page.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/components/fab_home.dart';
import 'package:svoz_odpadu/components/shared_preferences_global.dart';
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
    return Scaffold(
      backgroundColor: kDBackgroundColor,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kDMyAppBarHeight), child: MyAppBar()),
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
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
