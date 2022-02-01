// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:svoz_odpadu/components/calendar_item.dart';
import 'dart:convert';
import 'package:svoz_odpadu/towns/towns.dart';
import 'package:svoz_odpadu/components/utils.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class CalendarData {
  List<CalendarItem> calendarItems = [];
  List<CalendarItem> plasticCalendarItems = [];
  List<CalendarItem> paperCalendarItems = [];
  List<CalendarItem> bioCalendarItems = [];
  List<CalendarItem> mixedCalendarItems = [];
  List<List<CalendarItem>> nonZeroCalendarsItems = [];

  List<List<CalendarItem>> listOfNonZeroCalendarsItems() {
    List<List<CalendarItem>> nonZeroCalendarsItems = [];
    List calendarsItems = [
      mixedCalendarItems,
      plasticCalendarItems,
      paperCalendarItems,
      bioCalendarItems
    ];
    for (List<CalendarItem> calendar in calendarsItems) {
      if (calendar.isNotEmpty) {
        nonZeroCalendarsItems.add(calendar);
      }
    }
    print(nonZeroCalendarsItems.length);
    print('nonZeroCalendars: $nonZeroCalendarsItems');
    return nonZeroCalendarsItems;
  }

  bool isLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  ///stáhne data z calendarID a roztřídí je do wasteCalendarItems
  void getCalendarData(String cityPicked) async {
    Map? calendarID;
    /*Map<String, String> assignmentCityPickedToClass = {
      'Vybrat obec/město': '',
      'Dolní Kounice': 'dolniKounice',
    };*/

    ///jednotlivé instance zapojených měst
    DolniKounice dolniKounice = DolniKounice();
    if (cityPicked == dolniKounice.name) {
      calendarID = dolniKounice.calendarID;
    }

    await getCalendarDataFromGCalendar(calendarID!)
        .whenComplete(() => classifyCalendarData(calendarItems))
        .then(
      (value) {
        for (int i = 0; i <= nonZeroCalendarsItems.length -1; i++) {
          for (List<CalendarItem> calendar in nonZeroCalendarsItems) {
            Map<DateTime, List<Event>> wasteEvents = {};
            for (CalendarItem item in calendar) {
              if (item.summary == ('směs') ||
                  item.summary == ('směsný odpad')) {
                wasteEvents = mixedWasteEvents;
                print('mixedWasteEvents');
              } else if (item.summary == ('plast') ||
                  item.summary == ('plastový odpad')) {
                wasteEvents = plasticWasteEvents;
                print('plasticWasteEvents');
              } else if (item.summary == ('papír') ||
                  item.summary == ('papírový odpad')) {
                wasteEvents = paperWasteEvents;
                print('paperWasteEvents');
              } else if (item.summary == ('bio') ||
                  item.summary == ('bioodpad')) {
                wasteEvents = bioWasteEvents;
                print('bioWasteEvents');
              }
              createMapOfWasteCalendarData(
                  nonZeroCalendarsItems[i], wasteEvents);
            }
          }
        }
      },
    );

    //for(int i = 0; i < = )
    //createMapOfWasteCalendarData(wasteCalendarItems, wasteEvents);
  }

  ///načte data z GCalendar a vytvoří dle získaných dat stejné množství CalendarItem
  Future<List<CalendarItem>> getCalendarDataFromGCalendar(
      Map calendarID) async {
    //cyklus o počtu opakování dle počtu kalendářů
    for (int i = 0; i < calendarID.length; i++) {
      String calendarIDindex = calendarID.values.elementAt(i);
      //int index = i;
      //print('index $index, calendarIDindex $calendarIDindex');
      final url = Uri.parse(
          'https://www.googleapis.com/calendar/v3/calendars/$calendarIDindex/events?key=AIzaSyCCpkDJ_trt3VZpmaSqQRdLTPJBAVmg5vY');

      try {
        http.Response response = await http.get(url);
        //print(response.statusCode);

        //pokud bude zpětná 200, tak jede dál
        if (response.statusCode == 200) {
          //print('jedu přes if');
          String responseData = response.body;
          List<dynamic> itemsResponseData = jsonDecode(responseData)['items'];
          for (int i = 0; i < itemsResponseData.length; i++) {
            if (itemsResponseData[i]['status'] != 'cancelled') {
              CalendarItem calendarItem = CalendarItem(
                  status: itemsResponseData[i]['status'],
                  summary:
                      itemsResponseData[i]['summary'].toString().toLowerCase(),
                  start: itemsResponseData[i]['start']['date'],
                  end: itemsResponseData[i]['end']['date'],
                  recurrence: itemsResponseData[i]['recurrence'] != null
                      ? itemsResponseData[i]['recurrence'][0]
                      : 'not');
              //print(calendarItem);
              calendarItems.add(calendarItem);
              //print('calendarItemsList: ${calendarItems.length}');
            }
          }
          //print('calendarItems: $calendarItems');
        }
      } catch (e) {
        print(e);
        print('nestažena data z calendáře!!!');
      }
    }
    print('getData complete, ${calendarItems.length}');
    return calendarItems;
  }

  ///vezme rozřazený calendarItems a vytvoří počet event dle zvoleného opakování.
  void classifyCalendarData(List<CalendarItem> calendarItems) {
    if (calendarItems != null) {
      //print('classifyCalendar $calendarItems');
      for (var element in calendarItems) {
        //print(element.summary);
        if (element.summary == 'směsný' ||
            element.summary == 'směsný odpad' ||
            element.summary == 'komunální odpad' ||
            element.summary == 'komunální') {
          mixedCalendarItems.add(element);
          //print('Přidáno do mixed');
        } else if (element.summary == 'plast' ||
            element.summary == 'plastový odpad') {
          plasticCalendarItems.add(element);
          //print('Přidáno do plastic');
        } else if (element.summary == 'papír' ||
            element.summary == 'papírový odpad') {
          paperCalendarItems.add(element);
          //print('Přidáno do paper');
        } else if (element.summary == 'bio' || element.summary == 'bioodpad') {
          bioCalendarItems.add(element);
          //print('Přidáno do bio');
        }
      }
    }

    nonZeroCalendarsItems = listOfNonZeroCalendarsItems();
    print('classifyCalendarData complete, ${nonZeroCalendarsItems.length}');
  }

  void createMapOfWasteCalendarData(List wasteCalendarItems, Map wasteEvents) {
    String? freq;
    // ignore: unused_local_variable
    String? wkst;
    String? until;
    String? interval;
    // ignore: unused_local_variable
    String? byDay;
    String? nameOfWasteEvents;
    List<DateTime> daysList = [];
    for (CalendarItem item in wasteCalendarItems) {
      String recurrence = item.recurrence;
      String start = item.start;
      //print('item v create: $item');
      if (recurrence != 'not') {
        //print('recurrence není not');
        List<String> recurrenceSplit = recurrence.substring(6).split(';');
        //print('recurrenceSplit: $recurrenceSplit');
        for (var element in recurrenceSplit) {
          if (element.startsWith('FREQ')) {
            freq = element.substring(5);
            //print('freq: $freq');
          }
          if (element.startsWith('WKST')) {
            wkst = element.substring(5);
            //print('wkst: $wkst');
          }
          if (element.startsWith('UNTIL')) {
            until = element.substring(6);
            //print('until: $until');
          }
          if (element.startsWith('INTERVAL')) {
            interval = element.substring(9);
            //print('interval: $interval');
          }
          if (element.startsWith('BYDAY')) {
            byDay = element.substring(6);
            //print('byday: $byDay');
          }
        }
        DateTime startDate = DateTime.parse(start);
        // print('startDate: $startDate');
        DateTime endDate = DateTime.parse(until!);
        //print('endDate: $endDate');
        if (freq == 'WEEKLY') {
          //print('freq je weekly');
          int days = 7 * int.parse(interval!);
          DateTime tmp =
              DateTime(startDate.year, startDate.month, startDate.day);
          for (tmp;
              tmp.compareTo(endDate) <= 0 /*|| tmp.isAtSameMomentAs(endDate)*/;
              tmp = tmp.add(
            Duration(days: days),
          ),) {
            daysList.add(tmp);
          }
          //print(daysList);
        } else if (freq == 'MONTHLY') {
          //print('freq je monthly');
          int? tmpDays;
          int days = tmpDays! * int.parse(interval!);
          DateTime tmp =
              DateTime(startDate.year, startDate.month, startDate.day);
          for (tmp;
              tmp.compareTo(endDate) <= 0 /*|| tmp.isAtSameMomentAs(endDate)*/;
              tmp = tmp.add(Duration(days: days))) {
            if (tmp.month == DateTime.january ||
                tmp.month == DateTime.march ||
                tmp.month == DateTime.may ||
                tmp.month == DateTime.july ||
                tmp.month == DateTime.august ||
                tmp.month == DateTime.october ||
                tmp.month == DateTime.december) {
              tmpDays = 31;
            } else if (tmp.month == DateTime.april ||
                tmp.month == DateTime.june ||
                tmp.month == DateTime.september ||
                tmp.month == DateTime.november) {
              tmpDays = 30;
            } else {
              if (isLeapYear(tmp.year)) {
                tmp = tmp.add(
                  const Duration(days: 29),
                );
              } else {
                tmp = tmp.add(
                  const Duration(days: 28),
                );
              }
              daysList.add(tmp);
            }
            //print(daysList);
          }
        }
      }
      for (DateTime dateTime in daysList) {
        wasteEvents.putIfAbsent(
            dateTime,
            () => [
                  Event(item.summary),
                ]);
        //print(wasteEvents);
        nameOfWasteEvents = item.summary;
      }
    }
    print('wasteEvents : ${wasteEvents.length}');
    print('createMapOfWasteCalendarData $nameOfWasteEvents. is complete');
  }
}
