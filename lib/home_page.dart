import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:svoz_odpadu/constants/constants.dart';
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
    initializeDateFormatting(); //very important
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('cs');
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kDMyAppBarHeight), child: MyAppBar()),
      body: Container(
        margin: const EdgeInsets.only(
            left: kDMargin, right: kDMargin, top: kDMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              focusedDay: dateTimeNow,
              firstDay: dateTimeFirstDay,
              lastDay: dateTimeLastDay,
              locale: 'cs_CZ',
              calendarStyle: const CalendarStyle(
                  defaultTextStyle: TextStyle(
                      fontSize: kDFontSizeText,
                      fontFamily: kDFontFamilyParagraph,
                      color: Colors.black),
                  todayDecoration: BoxDecoration(
                    color: kDBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  weekendTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: kDFontSizeText,
                      fontFamily: kDFontFamilyParagraph)),
            ),
          ],
        ),
      ),
    );
  }
}
