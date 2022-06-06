// ignore_for_file: avoid_print, unused_local_variable

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:svoz_odpadu/components/calendar_item.dart';
import 'dart:convert';
import 'package:svoz_odpadu/towns/towns.dart';
import 'package:svoz_odpadu/components/utils.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

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
  List<CalendarItem> plasticCalendarItemsCancelled = [];
  List<CalendarItem> paperCalendarItemsCancelled = [];
  List<CalendarItem> bioCalendarItemsCancelled = [];
  List<CalendarItem> mixedCalendarItemsCancelled = [];

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
    List<List<CalendarItem>> allCalendarsItems = [
      mixedCalendarItems,
      plasticCalendarItems,
      paperCalendarItems,
      bioCalendarItems
    ];
    /*Map<String, String> assignmentCityPickedToClass = {
      'Vybrat obec/město': '',
      'Dolní Kounice': 'dolniKounice',
    };*/

    //jednotlivé instance zapojených měst
    DolniKounice dolniKounice = DolniKounice();
    ZoweluTestTown zoweluTestTown = ZoweluTestTown();
    if (cityPicked == dolniKounice.name) {
      calendarID = dolniKounice.calendarID;
      valueCityPickedPath = dolniKounice.iconPath;
      isKounice = true;
    } else if (cityPicked == zoweluTestTown.name) {
      calendarID = zoweluTestTown.calendarID;
      valueCityPickedPath = zoweluTestTown.iconPath;
    }

    await getCalendarDataFromGCalendar(calendarID!);
    await classifyCalendarData(calendarItems);
    for (List<CalendarItem> calendar in allCalendarsItems) {
      if (calendar.isNotEmpty) {
        await classifyConfirmedAndCancelled(calendar);
        await createAllWasteItems(calendar);
        await createMapOfWasteCalendarData(calendar);
      }
    }
    await getAllWasteEventOverviewList();
    await getAllWasteEventFromNow();
    await getAllWasteEventCalendar();

    /*for (int i = 0; i < allWasteEventsCalendar.length; i++) {
      print(
          'allWasteEventsCalendar key: ${allWasteEventsCalendar.keys.elementAt(i)}, value ${allWasteEventsCalendar.values.elementAt(i)}');
    }
    for (int i = 0; i < allWasteEventsOverviewList.length; i++) {
      print(
          'allWasteEventsOverviewList key: ${allWasteEventsOverviewList.keys.elementAt(i)}, value ${allWasteEventsOverviewList.values.elementAt(i)}');
    }*/
    /*for (int i = 0; i < allWasteEventsOverviewListFromNow.length; i++) {
      print(
          'allWasteEventsOverviewListFromNow key: ${allWasteEventsOverviewListFromNow.keys.elementAt(i)}, value ${allWasteEventsOverviewListFromNow.values.elementAt(i)}');
    }*/
    /*for (int i = 0; i < mixedWasteEvents.length; i++) {
      print(
          'mixedWasteEvents key: ${mixedWasteEvents.keys.elementAt(i)}, value ${mixedWasteEvents.values.elementAt(i)}');
    }*/
    /*for (int i = 0; i < plasticWasteEvents.length; i++) {
      print(
          'plasticWasteEvents after allkey: ${plasticWasteEvents.keys.elementAt(i)}, value ${plasticWasteEvents.values.elementAt(i)}');
    }*/ /*for (int i = 0; i < paperWasteEvents.length; i++) {
      print(
          'paperWasteEvents key: ${paperWasteEvents.keys.elementAt(i)}, value ${paperWasteEvents.values.elementAt(i)}');
    }for (int i = 0; i < bioWasteEvents.length; i++) {
      print(
          'bioWasteEvents key: ${bioWasteEvents.keys.elementAt(i)}, value ${bioWasteEvents.values.elementAt(i)}');
    }*/
    return;
  }

  //načte data z GCalendar a vytvoří dle získaných dat stejné množství CalendarItem
  Future<List<CalendarItem>> getCalendarDataFromGCalendar(
      Map calendarID) async {
    //cyklus o počtu opakování dle počtu kalendářů
    for (int i = 0; i < calendarID.length; i++) {
      String calendarIDindex = calendarID.values.elementAt(i);
      //int index = i;
      //print('index $index, calendarIDindex $calendarIDindex');
      final url = Uri.parse(
          'https://www.googleapis.com/calendar/v3/calendars/$calendarIDindex/events?key=AIzaSyB6op7SkNQjom3XP8sZkwhYkxew3vhdoKg');
      try {
        http.Response response = await http.get(url);
        print('response code ${response.statusCode}');

        //pokud bude zpětná 200, tak jede dál
        if (response.statusCode == 200) {
          //print('jedu přes if');
          String responseDataFull = response.body;
          //print('Response data full $responseDataFull');
          Map<String, dynamic> responseData = jsonDecode(responseDataFull);
          List<dynamic> itemsResponseData =
              jsonDecode(responseDataFull)['items'];
          String calendarName = responseData['summary'];
          //print('calendarName: $calendarName');
          //opakuje cyklus dle počtu items v ve staženém json
          for (int i = 0; i < itemsResponseData.length; i++) {
            CalendarItem calendarItem = CalendarItem(
                calendarName: calendarName.toString().toLowerCase(),
                status: itemsResponseData[i]['status'],
                summary: itemsResponseData[i]['summary'] != null
                    ? itemsResponseData[i]['summary'].toString().toLowerCase()
                    : 'not',
                start: itemsResponseData[i]['start'] != null
                    ? itemsResponseData[i]['start']['date']
                    : itemsResponseData[i]['originalStartTime']['date'],
                end: itemsResponseData[i]['end'] != null
                    ? itemsResponseData[i]['end']['date']
                    : 'not',
                id: itemsResponseData[i]['id'] ??
                    itemsResponseData[i]['recurringEventId'],
                recurrence: itemsResponseData[i]['recurrence'] != null
                    ? itemsResponseData[i]['recurrence'][0]
                    : 'not');
            calendarItems.add(calendarItem);
            //print('calendarItems: $calendarItems');
          }
        }
        //v případě chyby vypíše chybu
      } catch (e) {
        print(e);
        print('nestažena data z calendáře!!!');
      }
    }
    print('getCalendarDataFromGCalendar completed');
    return calendarItems;
  }

  //rozřadí calendarItems do wasteCalendarItems dle calendarName
  Future classifyCalendarData(List<CalendarItem> calendarItems) async {
    //cyklus o počtu opakování dle počtu items v calendarItems
    for (CalendarItem calendarItem in calendarItems) {
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
    }
    print('classifyCalendarData completed');
    return;
  }

  //z jednotlivých wasteCalendarItems vyextrahuje cancelled items a hodí je do přiřazených cancelled list
  Future classifyConfirmedAndCancelled(
      List<CalendarItem> wasteCalendarItems) async {
    if (wasteCalendarItems.isNotEmpty) {
      Map<List<CalendarItem>, List<CalendarItem>>
          clasiffyListOfWasteItemsCancelled = {
        mixedCalendarItems: mixedCalendarItemsCancelled,
        plasticCalendarItems: plasticCalendarItemsCancelled,
        paperCalendarItems: paperCalendarItemsCancelled,
        bioCalendarItems: bioCalendarItemsCancelled
      };

      List<CalendarItem> wasteCalendarItemsCancelled =
          clasiffyListOfWasteItemsCancelled[wasteCalendarItems]!;

      for (CalendarItem calendarItem in wasteCalendarItems) {
        if (calendarItem.status == 'cancelled') {
          wasteCalendarItemsCancelled.add(calendarItem);
          //print('classifyConfirmedAndCancelled: ${calendarItem}');
        }
      }
      for (CalendarItem calendarItem in wasteCalendarItemsCancelled) {
        wasteCalendarItems.remove(calendarItem);
      }
    }
    //wasteCalendarItems = was teCalendarItemsDuplicate;
    print(
        'classifyConfirmedAndCancelled ${wasteCalendarItems.last.summary} completed');
    return;
  }

  //vytvoří list, který bude obsahovat všechny data po vypočtení opakování
  Future<List<DateTime>> createAllWasteItems(
      List<CalendarItem> wasteCalendarItems) async {
    Map<List<CalendarItem>, List<CalendarItem>>
        clasiffyListOfWasteItemsCancelled = {
      mixedCalendarItems: mixedCalendarItemsCancelled,
      plasticCalendarItems: plasticCalendarItemsCancelled,
      paperCalendarItems: paperCalendarItemsCancelled,
      bioCalendarItems: bioCalendarItemsCancelled
    };

    List<CalendarItem> wasteCalendarItemsCancelled =
        clasiffyListOfWasteItemsCancelled[wasteCalendarItems]!;

    List<DateTime> daysList = [];

    for (CalendarItem calendarItem in wasteCalendarItems) {
      String itemName = calendarItem.summary;
      String recurrence = calendarItem.recurrence;
      String start = calendarItem.start;
      String? freq;
      String? wkst;
      String? until;
      String? interval;
      DateTime? endDate;
      int hours = 2;

      String? byDay;
      DateTime startDate = DateTime.parse(start);
      //pokud bude recurrence, tak dojde k získání dat každého calendarItem recurrence a následně se do listu
      //tolik dní, kolik bylo v plánu opakování
      if (recurrence != 'not') {
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
            endDate = DateTime.parse(until);
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
      }

      if (freq == 'WEEKLY') {
        //print('freq je weekly');
        int days = 7 * int.parse(interval!);
        DateTime tmp = DateTime(startDate.year, startDate.month, startDate.day);
        for (tmp;
            tmp.compareTo(endDate!) <= 0 /*|| tmp.isAtSameMomentAs(endDate)*/;
            tmp = tmp.add(
          Duration(days: days),
        ),) {
          tmp.add(Duration(hours: hours));
          daysList.add(tmp);
        }
        //print(daysList);
      } else if (freq == 'MONTHLY') {
        //print('freq je monthly');
        int? tmpDays;
        int days = tmpDays! * int.parse(interval!);
        DateTime tmp = DateTime(startDate.year, startDate.month, startDate.day);
        for (tmp;
            tmp.compareTo(endDate!) <= 0 /*|| tmp.isAtSameMomentAs(endDate)*/;
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
          tmp.add(Duration(hours: hours));
          daysList.add(tmp);
        }
      } else if (freq == 'DAILY') {
        //print('freq je DAILY');
        interval = '1';
        int days = 1 * int.parse(interval);
        DateTime tmp = DateTime(startDate.year, startDate.month, startDate.day);
        for (tmp;
            tmp.compareTo(endDate!) <= 0 /*|| tmp.isAtSameMomentAs(endDate)*/;
            tmp = tmp.add(
          Duration(days: days),
        ),) {
          tmp.add(Duration(hours: hours));
          daysList.add(tmp);
        }
        //print(daysList);
      } else {
        startDate.add(Duration(hours: hours));
        daysList.add(startDate);
      }
    }
    List<DateTime> daysListCancelled =
        await createCancelledItems(wasteCalendarItemsCancelled);

    for (DateTime dateCancelled in daysListCancelled) {
      if (daysList.contains(dateCancelled)) {
        daysList.remove(dateCancelled);
      }
    }
    List<DateTime> daysListFormatted = [];

    //projede každý date v daysList a přidá mu dvě hodiny, abychom předešli střídání času +- hodina letní a zimní
    for (DateTime date in daysList) {
      var newHour = 2;
      DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
      DateTime dateFormated = DateTime.parse(formatter.format(date));
      dateFormated =
          DateTime(date.year, date.month, date.day, newHour, date.minute);
      daysListFormatted.add(dateFormated);
      //print('date: $dateFormated');
    }
    print(
        'createAllWasteItems: ${wasteCalendarItems.first.calendarName} completed');
    print('createAllWasteItems: $wasteCalendarItems');
    return daysListFormatted;
  }

  //vytvoří list cancelled date
  Future<List<DateTime>> createCancelledItems(
      List<CalendarItem> wasteCalendarItemsCancelled) async {
    List<DateTime> daysListCancelled = [];
    if (wasteCalendarItemsCancelled.isNotEmpty) {
      for (CalendarItem calendarItem in wasteCalendarItemsCancelled) {
        DateTime date = DateTime.parse(calendarItem.start);
        daysListCancelled.add(date);
      }
    }
    print('createCancelledItems complete');
    return daysListCancelled;
  }

  //dle jednotlivých wasteCalendarItems přidá do jednotlivých wasteEvents vytvořené map s event
  Future<void> createMapOfWasteCalendarData(
      List<CalendarItem> wasteCalendarItems) async {
    Map<List<CalendarItem>, Map<DateTime, List<Event>>>
        clasiffyListOfWasteItemsToEvents = {
      mixedCalendarItems: mixedWasteEvents,
      plasticCalendarItems: plasticWasteEvents,
      paperCalendarItems: paperWasteEvents,
      bioCalendarItems: bioWasteEvents
    };

    Map<DateTime, List<Event>> wasteEvents =
        clasiffyListOfWasteItemsToEvents[wasteCalendarItems]!;

    List<DateTime> daysList = await createAllWasteItems(wasteCalendarItems);
    String name = wasteCalendarItems.first.summary;
    for (DateTime date in daysList) {
      wasteEvents[date] = [Event(name)];
      print('classify: ${wasteEvents[date]} , ${Event(name)}');
    }
    print('createMapOfWasteCalendarData completed');
  }

  Future<Map<DateTime, List<Event>>> getAllWasteEventCalendar() async {
    /*for (int i = 0; i < bioWasteEvents.length; i++) {
      print(
          'getAllWasteEventCalendar key: ${bioWasteEvents.keys.elementAt(i)}, value ${bioWasteEvents.values.elementAt(i)}');
    }*/

    List<Map<DateTime, List<Event>>> listOfWasteEvents = [
      mixedWasteEvents,
      plasticWasteEvents,
      paperWasteEvents,
      bioWasteEvents,
    ];

    int hours;
    //allWasteEventsCalendar.clear();
    for (Map<DateTime, List<Event>> wasteEvents in listOfWasteEvents) {
      for (int i = 0; i < wasteEvents.length; i++) {
        print(
            'wasteEvents key: ${wasteEvents.keys.elementAt(i)}, value ${wasteEvents.values.elementAt(i)}');
      }
      if (wasteEvents.isNotEmpty) {
        for (int i = 0; i < wasteEvents.length; i++) {
          DateTime dateTime = wasteEvents.keys.elementAt(i);
          List<Event> listEvent = wasteEvents.values.elementAt(i);
          if (allWasteEventsCalendar.keys.contains(dateTime)) {
            List<Event> newListEvent = allWasteEventsCalendar[dateTime]!;
            for (Event event in listEvent) {
              newListEvent.add(event);
            }
            allWasteEventsCalendar[dateTime] = newListEvent;
          } else {
            allWasteEventsCalendar[dateTime] = listEvent;
          }
        }
      }
    }

    Map<DateTime, List<Event>> allWasteEventsCalendarSorted =
        SortedMap(const Ordering.byKey());
    allWasteEventsCalendarSorted.addAll(allWasteEventsCalendar);
    allWasteEventsCalendar.clear();
    allWasteEventsCalendar.addAll(allWasteEventsCalendarSorted);

    for (int i = 0; i < allWasteEventsOverviewList.length; i++) {
      print(
          'key: ${allWasteEventsOverviewList.keys.elementAt(i)}, value ${allWasteEventsOverviewList.values.elementAt(i)}');
    }

    print('getAllWasteEventCalendar completed');

    return allWasteEventsCalendar;
  }

  Future<Map<DateTime, List<Event>>> getAllWasteEventOverviewList() async {
    /*for (int i = 0; i < bioWasteEvents.length; i++) {
      print(
          'getAllWasteEventOverviewList key: ${bioWasteEvents.keys.elementAt(i)}, value ${bioWasteEvents.values.elementAt(i)}');
    }*/

    List<Map<DateTime, List<Event>>> listOfWasteEvents = [
      mixedWasteEvents,
      plasticWasteEvents,
      paperWasteEvents,
      bioWasteEvents,
    ];

    /* for (int i = 0; i < plasticWasteEvents.length; i++) {
      print(
          'plasticWasteEvents OverviewList key: ${plasticWasteEvents.keys.elementAt(i)}, value ${plasticWasteEvents.values.elementAt(i)}');
    }
    for (int i = 0; i < bioWasteEvents.length; i++) {
      print(
          'bioWasteEvents OverviewList key: ${bioWasteEvents.keys.elementAt(i)}, value ${bioWasteEvents.values.elementAt(i)}');
    }*/
    int hours;
    //allWasteEventsOverviewList.clear();
    for (Map<DateTime, List<Event>> wasteEvents in listOfWasteEvents) {
      if (wasteEvents.isNotEmpty) {
        for (int i = 0; i < wasteEvents.length; i++) {
          DateTime dateTime = wasteEvents.keys.elementAt(i);
          List<Event> listEvent = wasteEvents.values.elementAt(i);
          /*print(
              'event calendar key: ${plasticWasteEvents.keys.elementAt(i)}, value ${plasticWasteEvents.values.elementAt(i)}');*/
          if (allWasteEventsOverviewList.keys.contains(dateTime)) {
            hours = 4;
            DateTime tmp = DateTime(dateTime.year, dateTime.month, dateTime.day,
                hours, dateTime.minute);
            allWasteEventsOverviewList[tmp] = listEvent;
          } else {
            List<Event> newListEvent = [];
            newListEvent.add(listEvent.first);
            allWasteEventsOverviewList[dateTime] = newListEvent;
          }
        }
      }
    }

    /*for (int i = 0; i < plasticWasteEvents.length; i++) {
      print(
          'plasticWasteEvents OverviewList 2 key: ${plasticWasteEvents.keys.elementAt(i)}, value ${plasticWasteEvents.values.elementAt(i)}');
    }
    for (int i = 0; i < bioWasteEvents.length; i++) {
      print(
          'bioWasteEvents OverviewList 2 key: ${bioWasteEvents.keys.elementAt(i)}, value ${bioWasteEvents.values.elementAt(i)}');
    }*/

    Map<DateTime, List<Event>> allWasteEventsOverviewListSorted =
        SortedMap(const Ordering.byKey());
    allWasteEventsOverviewListSorted.addAll(allWasteEventsOverviewList);
    allWasteEventsOverviewList.clear();
    allWasteEventsOverviewList.addAll(allWasteEventsOverviewListSorted);

    for (int i = 0; i < allWasteEventsOverviewList.length; i++) {
      print(
          'key: ${allWasteEventsOverviewList.keys.elementAt(i)}, value ${allWasteEventsOverviewList.values.elementAt(i)}');
    }
    print('getAllWasteEventOverviewList completed');
    return allWasteEventsOverviewList;
  }

  Future<Map<DateTime, List<Event>>> getAllWasteEventFromNow() async {
    DateTime now = DateTime.now();

    for (int i = 0; i < allWasteEventsOverviewList.length; i++) {
      DateTime dateTime = allWasteEventsOverviewList.keys.elementAt(i);
      List<Event> listEvent = allWasteEventsOverviewList.values.elementAt(i);
      if (now.isBefore(allWasteEventsOverviewList.keys.elementAt(i))) {
        allWasteEventsOverviewListFromNow[dateTime] = listEvent;
      }
    }
    /*for (int i = 0; i < allWasteEventsOverviewListFromNow.length; i++) {
      print(
          'key: ${allWasteEventsOverviewListFromNow.keys.elementAt(i)}, value ${allWasteEventsOverviewListFromNow.values.elementAt(i)}');
    }*/
    print('allWasteEventsOverviewListFromNow is completed');
    return allWasteEventsOverviewListFromNow;
  }
}
