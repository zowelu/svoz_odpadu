import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/about_app_page.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/components/divider_menu.dart';
import 'package:svoz_odpadu/components/open_url_in_browser.dart';
import 'package:svoz_odpadu/components/shared_preferences_global.dart';
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
    getAllEventsToMap();
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

  SharedPreferencesGlobal sharedPreferencesGlobal = SharedPreferencesGlobal();

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
  double fontSize = 16;
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('cs');
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kDMyAppBarHeight), child: MyAppBar()),
      drawer: Drawer(
        backgroundColor: kDBackgroundColorCalendar,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: kDBoxShadowColor,
                        offset: Offset(2, 0),
                        blurRadius: 10,
                        ),
                  ]),
                    child: DrawerHeader(
                      decoration: const BoxDecoration(color: kDBackgroundColor),
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/images/app_icon.png',
                            height: 100,
                          ),
                          const TextHeader(
                            text: 'Svoz odpadu',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(width: 300,padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: kDBackgroundColor,
                        borderRadius: kDRadiusLarge,
                        boxShadow: [
                          BoxShadow(
                              color: kDBoxShadowColor,
                              offset: Offset(2, 2),
                              blurRadius: 10,
                              spreadRadius: 2),
                        ]),
                    child: Column(
                      children: [
                        ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 80),
                            child: Image.asset(
                              'assets/images/DK_znak_200px.png',
                            )),
                        const TextHeader(
                          text: 'Město Dolní Kounice',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const DividerMenu(),
                      ListTile(
                        leading: const Icon(
                          Icons.perm_contact_calendar_outlined,
                          size: 30,
                          color: kDBackgroundColor,
                        ),
                        title: TextHeader(
                          text: 'Kalendář',
                          color: kDBackgroundColor,
                          fontSize: fontSize,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const DividerMenu(),
                      ListTile(
                        leading: const Icon(
                          Icons.home_outlined,
                          size: 30,
                          color: kDBackgroundColor,
                        ),
                        title: TextHeader(
                            text: 'Vybrat město/obec',
                            color: kDBackgroundColor,
                            fontSize: fontSize),
                        onTap: () {
                          Navigator.popAndPushNamed(context, CityPickerPage.id);
                        },
                      ),
                      const DividerMenu(),
                      ListTile(
                        leading: const Icon(
                          Icons.settings_outlined,
                          size: 30,
                          color: kDBackgroundColor,
                        ),
                        title: TextHeader(
                            text: 'Nastavení',
                            color: kDBackgroundColor,
                            fontSize: fontSize),
                        onTap: () {
                          Navigator.popAndPushNamed(context, SettingsPage.id);
                        },
                      ),
                      const DividerMenu(),
                      ListTile(
                        leading: const Icon(
                          Icons.announcement_outlined,
                          size: 30,
                          color: kDBackgroundColor,
                        ),
                        title: TextHeader(
                            text: 'Ohodnotit',
                            color: kDBackgroundColor,
                            fontSize: fontSize),
                        onTap: () {},
                      ),
                      const DividerMenu(),
                      ListTile(
                        leading: const Icon(
                          Icons.info_outline,
                          size: 30,
                          color: kDBackgroundColor,
                        ),
                        title: TextHeader(
                            text: 'O aplikaci',
                            color: kDBackgroundColor,
                            fontSize: fontSize),
                        onTap: () {
                          Navigator.popAndPushNamed(context, AboutAppPage.id);
                        },
                      ),
                      const DividerMenu(),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextNormal(
                    text: 'verze: $versionApp',
                    color: kDBackgroundColor,
                    fontSize: 14,
                  ),
                  Container(
                    decoration: const BoxDecoration(color: kDBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                              color: kDBoxShadowColor,
                              offset: Offset(2, 2),
                              blurRadius: 10,
                              spreadRadius: 2),
                        ]),
                    padding: const EdgeInsets.all(kDMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              OpenUrlInBrowser()
                                  .openUrl('https://www.webstrong.cz');
                            },
                            child: Image.asset(
                              'assets/images/webstrong-logo.png',
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 30,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              OpenUrlInBrowser()
                                  .openUrl('https://www.zowelu.cz');
                            },
                            child: Image.asset(
                              'assets/images/zowelu_logo.png',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                      color: kDBackgroundColorCalendar,
                      borderRadius: kDRadiusLarge),
                  child: ListView(
                    shrinkWrap: true,
                    children: const <Widget>[
                      ListTileOfWaste('Dnešní den', kDBackgroundColor),
                      ListTileOfWaste('Plast a nápojový karton,\nDrobné kovy',
                          kDColorWastePlastic),
                      ListTileOfWaste('Bioodpad', kDColorWasteBio),
                      ListTileOfWaste('Papír', kDColorWastePaper),
                      ListTileOfWaste('Směsný odpad', kDColorWasteMixed),
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
