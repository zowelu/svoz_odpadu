import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/components/button_settings.dart';
import 'package:svoz_odpadu/components/shared_preferences.dart';
import 'package:svoz_odpadu/settings_page.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:svoz_odpadu/components/list_tile_of_waste.dart';
import 'package:svoz_odpadu/components/utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:svoz_odpadu/components/marker_event.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'dart:io';

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
    initializeDateFormatting(); //very important
    getAllEventsToMap();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
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
    });

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

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      sharedPreferencesGlobal.getPreferencesValueCity();
      // ignore: avoid_print
      print('valueCityPickedGlobal from home: $valueCityPickedGlobal');
      if (valueCityPickedGlobal == false) {
        toCityPage();
      }
    });
  }

  SharedPreferencesGlobal sharedPreferencesGlobal = SharedPreferencesGlobal();


  void toCityPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const CityPickerPage(),
        ),
        (route) => route.isFirst);
  }

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

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('cs');

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kDMyAppBarHeight), child: MyAppBar()),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 100 * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: kDMargin, right: kDMargin),
                padding: const EdgeInsets.only(
                  left: kDMargin,
                  right: kDMargin,
                ),
                decoration: const BoxDecoration(
                    color: kDBackgroundColorCalendar,
                    borderRadius: kDRadiusLarge),
                child: TableCalendar(
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
                        children = MarkerEvent(kDColorWasteMixed, dayString);
                      } else if (event.toString() == 'Papír') {
                        children = MarkerEvent(kDColorWastePaper, dayString);
                      } else if (event.toString() ==
                          'Plast a nápojový karton, Drobné kovy') {
                        children = MarkerEvent(kDColorWastePlastic, dayString);
                      } else if (event.toString() == 'Bioodpad') {
                        children = MarkerEventGradient(
                            const [kDColorWastePlastic, kDColorWasteBio],
                            dayString);
                      }
                      return children;
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10), width: double.infinity,
                decoration:
                    const BoxDecoration(color: kDBackgroundColor, boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey,
                      blurRadius: 2.0,
                      offset: Offset(0, 0),
                      spreadRadius: 2),
                ]),
                //margin: const EdgeInsets.only(top: kDMarginLarger),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonSettings(onTap: () {Navigator.pushNamed(context, SettingsPage.id);}, title: 'Přejít na setting', subtitle: 'přejít', icon: Icons.settings),
                    Container(
                      width: MediaQuery.of(context).size.width / 100 * 75,
                      decoration: const BoxDecoration(
                          color: kDBackgroundColorCalendar,
                          borderRadius: kDRadiusLarge),
                      child: ListView(
                        shrinkWrap: true,
                        children: const <Widget>[
                          ListTileOfWaste('Dnešní den', kDBackgroundColor),
                          ListTileOfWaste('Plast a nápojový karton, Drobné kovy',
                              kDColorWastePlastic),
                          ListTileOfWaste('Bioodpad', kDColorWasteBio),
                          ListTileOfWaste('Papír', kDColorWastePaper),
                          ListTileOfWaste('Směsný odpad', kDColorWasteMixed),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
