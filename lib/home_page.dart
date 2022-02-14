import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/calendar_data.dart';
import 'package:svoz_odpadu/components/drawer_menu.dart';
import 'package:svoz_odpadu/components/fab_home.dart';
import 'package:svoz_odpadu/components/shared_preferences_global.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:svoz_odpadu/components/list_tile_of_waste_hint.dart';
import 'package:svoz_odpadu/components/utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:svoz_odpadu/components/marker_event.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'dart:io';
import 'package:svoz_odpadu/components/notifications.dart';

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
    initializeDateFormatting();
    cancelScheduledNotifications('scheduled_channel');
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const TextHeader(text: 'Souhlas s notifikacemi'),
              content: const TextNormal(
                  text:
                      'Aplikace by Vám ráda zasílala notifikace.\n\nBez Vašeho souhlasu Vás aplikace neupozorní na svoz odpadu'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Nesouhlasím',
                    style:
                        TextStyle(color: Colors.grey, fontSize: kDFontSizeText),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then(
                        (_) => Navigator.pop(context),
                      ),
                  child: const Text(
                    'Souhlasím',
                    style: TextStyle(
                        color: kDBackgroundColor,
                        fontSize: kDFontSizeText,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
    /*AwesomeNotifications().createdStream.listen((notification) {
      showSnackBar(context, 'Upozornění na každý týden bylo vytvořeno');
    });*/

    ///Po kliknutí na notifikaci otevře zvolenou stránku
    AwesomeNotifications().actionStream.listen(
      (notification) {
        if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
          AwesomeNotifications().getGlobalBadgeCounter().then(
                (value) =>
                    AwesomeNotifications().setGlobalBadgeCounter(value - 1),
              );
        }

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const HomePage(),
            ),
            (route) => route.isFirst);
      },
    );
  }

  double fontSize = 14;
  bool isKounice = true;

  SharedPreferencesGlobal sharedPreferencesGlobal = SharedPreferencesGlobal();
  FABHome fabHome = const FABHome();

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    currentPage = HomePage.id;
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
    //return allWasteEvents[day] ?? [];
  }

  //List<Event> _getEventsForMonth(DateTime month) {
  //  return kEvents[month] ?? [];
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('cs');
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kDMyAppBarHeight), child: MyAppBar()),
      drawer: const DrawerMenu(),
      floatingActionButton: fabHome,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: kDBackgroundColor,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined), label: 'Kalendář'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_outlined), label: 'Nejbližší svozy'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Nastavení'),
        ],
      ),
      body: Container(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height / 100 * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: kDMargin, right: kDMargin),
              padding: const EdgeInsets.only(
                  left: kDMargin, right: kDMargin, bottom: kDMargin),
              decoration: const BoxDecoration(
                  color: kDBackgroundColorCalendar,
                  borderRadius: kDRadiusLarge,
                  boxShadow: [
                    BoxShadow(
                        color: kDBoxShadowColor,
                        blurRadius: 10.0,
                        spreadRadius: 1.0)
                  ]),
              child: !isKounice
                  ? TableCalendar(
                      rowHeight: MediaQuery.of(context).size.height / 100 * 6,
                      eventLoader: (day) {
                        return _getEventsForDay(day);
                      },
                      calendarFormat: CalendarFormat.month,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      focusedDay: dateTimeNow,
                      firstDay: dateTimeFirstDay,
                      lastDay: dateTimeLastDay,
                      locale: 'cs_CZ',
                      calendarStyle: const CalendarStyle(
                        markerSizeScale: 1.35,
                        canMarkersOverflow: true,
                        outsideDaysVisible: false,
                        markerDecoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.rectangle),
                        markersMaxCount: 2,
                        isTodayHighlighted: true,
                        cellPadding: EdgeInsets.all(0),
                        cellMargin: EdgeInsets.all(0),
                        defaultDecoration: BoxDecoration(
                          borderRadius: kDRadius,
                        ),
                        defaultTextStyle: TextStyle(
                            fontSize: kDFontSizeText,
                            fontFamily: kDFontFamilyParagraph,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        todayTextStyle: TextStyle(
                            fontSize: kDFontSizeText,
                            fontFamily: kDFontFamilyParagraph,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        todayDecoration: BoxDecoration(
                          color: kDBackgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        weekendTextStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: kDFontSizeText,
                            fontFamily: kDFontFamilyParagraph),
                      ),
                      headerStyle: const HeaderStyle(
                        leftChevronIcon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: kDBackgroundColor),
                        rightChevronIcon: Icon(Icons.arrow_forward_ios_rounded,
                            color: kDBackgroundColor),
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontFamily: kDFontFamilyHeader,
                          fontSize: kDFontSizeHeader,
                          color: kDBackgroundColor,
                        ),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.blueGrey),
                        weekendStyle: TextStyle(color: Colors.blueGrey),
                      ),
                      calendarBuilders: CalendarBuilders(
                        singleMarkerBuilder: (context, day, event) {
                          //DateTime dayRaw = day;
                          DateFormat dateFormat = DateFormat('d');
                          String dayString = dateFormat.format(day);
                          Widget? children;
                          if (event.toString() == 'Směsný odpad') {
                            children =
                                MarkerEvent(kDColorWasteMixed, dayString);
                          } else if (event.toString() == 'Papír') {
                            children =
                                MarkerEvent(kDColorWastePaper, dayString);
                          } else if (event.toString() ==
                              'Plast a nápojový karton, Drobné kovy') {
                            children =
                                MarkerEvent(kDColorWastePlastic, dayString);
                          } else if (event.toString() == 'Bioodpad') {
                            children = MarkerEventGradient(
                                const [kDColorWastePlastic, kDColorWasteBio],
                                dayString);
                          }
                          return children;
                        },
                      ),
                    )
                  : TableCalendar(
                      rowHeight:
                          45 /*MediaQuery.of(context).size.height / 100 * 6*/,
                      eventLoader: (day) {
                        return _getEventsForDay(day);
                      },
                      calendarFormat: CalendarFormat.month,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      focusedDay: dateTimeNow,
                      firstDay: dateTimeFirstDay,
                      lastDay: dateTimeLastDay,
                      locale: 'cs_CZ',
                      calendarStyle: const CalendarStyle(
                        //markerSizeScale: 1.35,
                        canMarkersOverflow: true,
                        outsideDaysVisible: false,
                        markerDecoration: BoxDecoration(
                            color: Colors.yellow, shape: BoxShape.rectangle),
                        markersMaxCount: 5,
                        isTodayHighlighted: true,
                        /*cellPadding: EdgeInsets.all(10),
                  cellMargin: EdgeInsets.all(15),*/
                        //cellMargin: EdgeInsets.all(15),
                        /*defaultDecoration: BoxDecoration(
                    borderRadius: kDRadius,
                  ),*/
                        //defaultDecoration: BoxDecoration(),
                        defaultTextStyle: TextStyle(
                            fontSize: kDFontSizeText,
                            fontFamily: kDFontFamilyParagraph,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        todayTextStyle: TextStyle(
                            fontSize: kDFontSizeText,
                            fontFamily: kDFontFamilyParagraph,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        markerSizeScale: 0.4,
                        todayDecoration: BoxDecoration(
                          color: kDBackgroundColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        weekendTextStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: kDFontSizeText,
                            fontFamily: kDFontFamilyParagraph),
                      ),
                      headerStyle: const HeaderStyle(
                        leftChevronIcon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: kDBackgroundColor),
                        rightChevronIcon: Icon(Icons.arrow_forward_ios_rounded,
                            color: kDBackgroundColor),
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontFamily: kDFontFamilyHeader,
                          fontSize: kDFontSizeHeader,
                          color: kDBackgroundColor,
                        ),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.blueGrey),
                        weekendStyle: TextStyle(color: Colors.blueGrey),
                      ),
                      calendarBuilders: CalendarBuilders(
                        singleMarkerBuilder: (context, date, event) {
                          Map<String, Color> colorsOfWaste = {
                            'plast': kDColorWastePlastic,
                            'papír': kDColorWastePaper,
                            'směsný odpad': kDColorWasteMixed,
                            'bioodpad': kDColorWasteBio
                          };
                          Color cor = Colors.pink;
                          if (event.toString() == 'plast') {
                            cor = colorsOfWaste['plast']!;
                          }
                          if (event.toString() == 'papír') {
                            cor = colorsOfWaste['papír']!;
                          }
                          if (event.toString() == 'směsný odpad') {
                            cor = colorsOfWaste['směsný odpad']!;
                          }
                          if (event.toString() == 'bioodpad') {
                            cor = colorsOfWaste['bioodpad']!;
                          }
                          double size = 14;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 100),
                            child: Icon(
                              Icons.circle,
                              color: cor,
                              size: size,
                            ),
                          );
                        },
                      ),
                    ),
            ),
            Container(
              padding: const EdgeInsets.only(top: kDMargin, bottom: kDMargin),
              decoration: const BoxDecoration(
                  color: kDBackgroundColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20.0),
                    topEnd: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: kDBoxShadowColor,
                        blurRadius: 10.0,
                        spreadRadius: 1.0)
                  ]),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 100 * 75,
                  decoration: const BoxDecoration(
                      color: Colors.grey, borderRadius: kDRadiusLarge),
                  child: ListView(
                    shrinkWrap: true,
                    children: const <Widget>[
                      ListTileOfWasteHint('Dnešní den', kDBackgroundColor),
                      ListTileOfWasteHint(
                          'Plast a nápojový karton,\nDrobné kovy',
                          kDColorWastePlastic),
                      ListTileOfWasteHint('Bioodpad', kDColorWasteBio),
                      ListTileOfWasteHint('Papír', kDColorWastePaper),
                      ListTileOfWasteHint('Směsný odpad', kDColorWasteMixed),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
