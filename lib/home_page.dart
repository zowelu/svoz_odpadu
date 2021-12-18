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
            Container(
              padding: const EdgeInsets.only(
                  left: kDMargin, right: kDMargin, bottom: kDMargin),
              decoration: BoxDecoration(
                  color: kDBackgroundColorCalendar,
                  borderRadius: BorderRadius.circular(20.0)),
              child: TableCalendar(
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                focusedDay: dateTimeNow,
                firstDay: dateTimeFirstDay,
                lastDay: dateTimeLastDay,
                locale: 'cs_CZ',
                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: true,
                  defaultDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  defaultTextStyle: TextStyle(
                    fontSize: kDFontSizeText,
                    fontFamily: kDFontFamilyParagraph,
                    color: Colors.black,
                  ),
                  todayDecoration: BoxDecoration(
                    color: kDBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  weekendTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: kDFontSizeText,
                      fontFamily: kDFontFamilyParagraph),
                ),
                headerStyle: const HeaderStyle(
                  leftChevronIcon: Icon(Icons.arrow_back_ios_new_rounded),
                  rightChevronIcon: Icon(Icons.arrow_forward_ios_rounded),
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontFamily: kDFontFamilyHeader,
                    fontSize: kDFontSizeHeader,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.blueGrey),
                    weekendStyle: TextStyle(color: Colors.blueGrey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
