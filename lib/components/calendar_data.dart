// ignore_for_file: avoid_print, unused_local_variable

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
  List<CalendarItem> plasticCalendarItemsCancelled = [];
  List<CalendarItem> paperCalendarItemsCancelled = [];
  List<CalendarItem> bioCalendarItemsCancelled = [];
  List<CalendarItem> mixedCalendarItemsCancelled = [];
  List<List<CalendarItem>> nonZeroCalendarsItemsCancelled = [];

  List<List<CalendarItem>> listOfNonZeroCalendarsItems() {
    List<List<CalendarItem>> allCalendarsItems = [
      mixedCalendarItems,
      plasticCalendarItems,
      paperCalendarItems,
      bioCalendarItems
    ];

    for (List<CalendarItem> calendar in allCalendarsItems) {
      int index = nonZeroCalendarsItems.length;
      if (calendar.isNotEmpty) {
        nonZeroCalendarsItems.insert(index, calendar);
      }
    }

    print(nonZeroCalendarsItems.length);
    //print('nonZeroCalendars: $nonZeroCalendarsItems');
    return nonZeroCalendarsItems;
  }

  List<List<CalendarItem>> listOfNonZeroCalendarsItemsCancelled() {
    List<List<CalendarItem>> allCalendarsItems = [
      mixedCalendarItemsCancelled,
      plasticCalendarItemsCancelled,
      paperCalendarItemsCancelled,
      bioCalendarItemsCancelled
    ];

    for (List<CalendarItem> calendar in allCalendarsItems) {
      int index = nonZeroCalendarsItemsCancelled.length;
      if (calendar.isNotEmpty) {
        nonZeroCalendarsItemsCancelled.insert(index, calendar);
      }
    }

    print('nonZeroCancelled: ${nonZeroCalendarsItemsCancelled.length}');
    //print('nonZeroCalendars: $nonZeroCalendarsItems');
    return nonZeroCalendarsItemsCancelled;
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
  Future getCalendarData(String cityPicked) async {
    Map? calendarID;
    /*Map<String, String> assignmentCityPickedToClass = {
      'Vybrat obec/město': '',
      'Dolní Kounice': 'dolniKounice',
    };*/

    //jednotlivé instance zapojených měst
    DolniKounice dolniKounice = DolniKounice();
    if (cityPicked == dolniKounice.name) {
      calendarID = dolniKounice.calendarID;
    }

    await getCalendarDataFromGCalendar(calendarID!)
        .whenComplete(classifyAndCreateWasteEvents);
    return allWasteEvents;
  }

  void classifyAndCreateWasteEvents() {
    for (List<CalendarItem> calendar in nonZeroCalendarsItems) {
      print('classify: $calendar');
      if (calendar.first.summary == 'směsný' ||
          calendar.first.summary == 'směsný odpad') {
        createMapOfWasteCalendarData(calendar, mixedWasteEvents);
      } else if (calendar.first.summary == 'plast' ||
          calendar.first.summary == 'plastový odpad') {
        createMapOfWasteCalendarData(calendar, plasticWasteEvents);
      } else if (calendar.first.summary == 'papír' ||
          calendar.first.summary == 'papírový odpad') {
        createMapOfWasteCalendarData(calendar, paperWasteEvents);
      } else if (calendar.first.summary == 'bio' ||
          calendar.first.summary == 'bioodpad') {
        createMapOfWasteCalendarData(calendar, bioWasteEvents);
      }
    }
  }

  //načte data z GCalendar a vytvoří dle získaných dat stejné množství CalendarItem
  Future<List<List<CalendarItem>>> getCalendarDataFromGCalendar(
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
          //opakuje cyklus dle počtu items v ve staženém json
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

              //daný objekt rozřadí dle pojmenování do jednotlivých listů items odpadů
              if (calendarItem.summary == 'směsný' ||
                  calendarItem.summary == 'směsný odpad' ||
                  calendarItem.summary == 'komunální odpad' ||
                  calendarItem.summary == 'komunální') {
                mixedCalendarItems.add(calendarItem);
                //print('Přidáno do mixed');
              } else if (calendarItem.summary == 'plast' ||
                  calendarItem.summary == 'plastový odpad') {
                plasticCalendarItems.add(calendarItem);
                //print('Přidáno do plastic');
              } else if (calendarItem.summary == 'papír' ||
                  calendarItem.summary == 'papírový odpad') {
                paperCalendarItems.add(calendarItem);
                //print('Přidáno do paper');
              } else if (calendarItem.summary == 'bio' ||
                  calendarItem.summary == 'bioodpad') {
                bioCalendarItems.add(calendarItem);
                //print('Přidáno do bio$bioCalendarItems');
              }
            } else if (itemsResponseData[i]['status'] == 'cancelled') {
              CalendarItem calendarItem = CalendarItem(
                  status: itemsResponseData[i]['status'],
                  summary:
                      itemsResponseData[i]['summary'].toString().toLowerCase(),
                  start: itemsResponseData[i]['originalStartTime']['date'],
                  end: 'not',
                  recurrence: 'not');

              //daný objekt rozřadí dle pojmenování do jednotlivých listů items odpadů
              if (calendarItem.summary == 'směsný' ||
                  calendarItem.summary == 'směsný odpad' ||
                  calendarItem.summary == 'komunální odpad' ||
                  calendarItem.summary == 'komunální') {
                mixedCalendarItemsCancelled.add(calendarItem);
                //print('Přidáno do mixed');
              } else if (calendarItem.summary == 'plast' ||
                  calendarItem.summary == 'plastový odpad') {
                plasticCalendarItemsCancelled.add(calendarItem);
                //print('Přidáno do plastic');
              } else if (calendarItem.summary == 'papír' ||
                  calendarItem.summary == 'papírový odpad') {
                paperCalendarItemsCancelled.add(calendarItem);
                //print('Přidáno do paper');
              } else if (calendarItem.summary == 'bio' ||
                  calendarItem.summary == 'bioodpad') {
                bioCalendarItemsCancelled.add(calendarItem);
                //print('Přidáno do bio$bioCalendarItems');
              }
            }
          }

          //print('calendarItems: $calendarItems');
        }
        //v případě chyby vypíše chybu
      } catch (e) {
        print(e);
        print('nestažena data z calendáře!!!');
      }
    }
    listOfNonZeroCalendarsItems();
    listOfNonZeroCalendarsItemsCancelled();
    print('getData complete, ${nonZeroCalendarsItems.length}');
    return nonZeroCalendarsItems;
  }

  //na základě zvoleného wasteCalendarItems a wasteEvents rozřadí jednotlivé item
  //a vytvoří tolik DateTime, kolik je v recurrence. Na závěr přidá datum a Event do zvoleného wasteEvents
  void createMapOfWasteCalendarData(List<CalendarItem> wasteCalendarItems,
      Map<DateTime, List<Event>> wasteEvents) {
    for (CalendarItem item in wasteCalendarItems) {
      String? freq;
      String? wkst;
      String? until;
      String? interval;
      List<DateTime> daysList = [];
      String? byDay;
      String itemName = item.summary;
      String recurrence = item.recurrence;
      String start = item.start;
      DateTime startDate = DateTime.parse(start);
      //print('item v create: $item');

      if (recurrence != 'not') {
        //print('recurrence není not');
        List<String> recurrenceSplit = recurrence.substring(6).split(';');
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

        DateTime endDate = DateTime.parse(until!);

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
            }
            daysList.add(tmp);
          }
        } else {
          daysList.add(startDate);
        }
      } else {
        daysList.add(startDate);
      }
      //TODO: implementovat listofcalendarscancelled tak, aby se odstranili zrušené datetime
      for (DateTime date in daysList) {
        //if(wasteEvents.keys.contains(date)){
        if (!wasteEvents.containsKey(date)) {
          wasteEvents[date] = [Event(item.summary)];
        } else if (wasteEvents.containsKey(date)) {
          date.add(const Duration(hours: 1));
          wasteEvents[date]!.add(Event(item.summary));
        }
      }
    }
  }
}
