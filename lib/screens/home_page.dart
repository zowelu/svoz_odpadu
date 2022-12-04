import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:svoz_odpadu/services/calendar_service.dart';
import 'package:table_calendar/table_calendar.dart';

import '../favorite_colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final CalendarService _calendarService = GetIt.instance.get();

  @override
  Widget build(BuildContext context) {
    _calendarService.getCalendarConfirmedData();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text('Svoz odpadu')),
      body: SafeArea(
        child: TableCalendar(
          rowHeight: MediaQuery.of(context).size.height / 100 * 6,
          eventLoader: (day) {
            return [DateTime(2022, 11, 6)];
            /*_getEventsForDay(day)*/
          },
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          focusedDay: DateTime(2022, 11, 6),
          firstDay: DateTime(2022, 01, 01),
          lastDay: DateTime(2022, 12, 31),
          locale: 'cs_CZ',
          calendarStyle: CalendarStyle(
            markerSizeScale: 1.35,
            canMarkersOverflow: true,
            outsideDaysVisible: false,
            markersMaxCount: 5,
            isTodayHighlighted: true,
            cellPadding: const EdgeInsets.all(0),
            cellMargin: const EdgeInsets.all(0),
            defaultTextStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            todayTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
            todayDecoration: BoxDecoration(
              color: FavoriteColors().backgroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            weekendTextStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
          headerStyle: HeaderStyle(
            leftChevronIcon: Icon(Icons.arrow_back_ios_new_rounded,
                color: FavoriteColors().backgroundColor),
            rightChevronIcon: Icon(Icons.arrow_forward_ios_rounded,
                color: FavoriteColors().backgroundColor),
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              color: FavoriteColors().backgroundColor,
            ),
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.blueGrey),
            weekendStyle: TextStyle(color: Colors.blueGrey),
          ),
          calendarBuilders: CalendarBuilders(
            singleMarkerBuilder: (context, date, event) {
              Map<String, Color> colorsOfWaste = {
                'plast': FavoriteColors().colorWastePlastic,
                'papír': FavoriteColors().colorWastePaper,
                'směsný odpad': FavoriteColors().colorWasteMixed,
                'bioodpad': FavoriteColors().colorWasteBio
              };
              Color cor = Colors.pink;
              if (event.toString() == 'Plast'.toLowerCase()) {
                cor = colorsOfWaste['plast']!;
              }
              if (event.toString() == 'Papír'.toLowerCase()) {
                cor = colorsOfWaste['papír']!;
              }
              if (event.toString() == 'Směsný odpad'.toLowerCase()) {
                cor = colorsOfWaste['směsný odpad']!;
              }
              if (event.toString() == 'Bio'.toLowerCase()) {
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
            /*singleMarkerBuilder: (context, day, event) {
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
                      },*/
          ),
        ),
      ),
    );
  }
}
