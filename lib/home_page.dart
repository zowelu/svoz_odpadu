import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:svoz_odpadu/components/list_tile_of_waste.dart';
import 'package:svoz_odpadu/utils.dart';
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
    getAllEventsToMap();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: kDMargin, right: kDMargin),
            padding: const EdgeInsets.only(
                left: kDMargin, right: kDMargin, bottom: kDMargin),
            decoration: const BoxDecoration(
                color: kDBackgroundColorCalendar,
                borderRadius: kDRadiusLarge),
            child: TableCalendar(
              eventLoader: _getEventsForDay,
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              focusedDay: dateTimeNow,
              firstDay: dateTimeFirstDay,
              lastDay: dateTimeLastDay,
              locale: 'cs_CZ',
              calendarStyle: const CalendarStyle(
                canMarkersOverflow: true,
                outsideDaysVisible: false,
                markerDecoration: BoxDecoration(
                    color: Colors.black, shape: BoxShape.rectangle),
                markersMaxCount: 4,
                isTodayHighlighted: true,
                defaultDecoration: BoxDecoration(
                  borderRadius: kDRadius,
                ),
                defaultTextStyle: TextStyle(
                  fontSize: kDFontSizeText,
                  fontFamily: kDFontFamilyParagraph,
                  color: Colors.black,
                ),
                todayDecoration: BoxDecoration(
                  color: kDBackgroundColor,
                  borderRadius: kDRadius,
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
                  print(event);
                  Widget? children;
                  if (event.toString() == 'Směsný odpad') {
                    children = const MarkerEvent(kDColorWasteMixed);
                  } else if (event.toString() == 'Papír') {
                    children = const MarkerEvent(kDColorWastePaper);
                  }
                  if (event.toString() == 'Bioodpad') {
                    children = const MarkerEvent(kDColorWasteBio);
                  }
                  if (event.toString() ==
                      'Plast a nápojový karton, Drobné kovy') {
                    children = const MarkerEvent(kDColorWastePlastic);
                  }
                  return children;
                },
              ),
            ),
          ),
          Container(
            color: kDBackgroundColor,
            padding: const EdgeInsets.all(kDMarginLarger),
            margin: const EdgeInsets.only(top:kDMarginLarger),

            child: ListView(

              shrinkWrap: true,
              children: const <Widget>[
                ListTileOfWaste('Plast a nápojový karton\nDrobné kovy',
                    kDColorWastePlastic),
                ListTileOfWaste('Bioodpad', kDColorWasteBio),
                ListTileOfWaste('Papír', kDColorWastePaper),
                ListTileOfWaste('Směsný odpad', kDColorWasteMixed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MarkerEvent extends StatelessWidget {
  const MarkerEvent(this.color, {Key? key}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: kDRadiusSmall
      ),
    );
  }
}
