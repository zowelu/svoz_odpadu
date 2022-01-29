// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:svoz_odpadu/components/calendar_item.dart';
import 'dart:convert';

import 'package:svoz_odpadu/components/utils.dart';

class CalendarData {
  List<CalendarItem> calendarItems = [];
  List<CalendarItem> plasticCalendarItems = [];
  List<CalendarItem> paperCalendarItems = [];
  List<CalendarItem> bioCalendarItems = [];
  List<CalendarItem> mixedCalendarItems = [];

  Map<DateTime, List<Event>> mixedWasteEvents = {};
  Map<DateTime, List<Event>> plasticWasteEvents= {};
  Map<DateTime, List<Event>> bioWasteEvents= {} ;
  Map<DateTime, List<Event>> paperWasteEvents = {};

  ///načte data z GCalendar a vytvoří dle získaných dat stejné množství CalendarItem
  Future<List<CalendarItem>> getCalendarData(Map calendarID) async {
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
    print('getData complete');
    return calendarItems;
  }

  void classifyCalendarData() {
    //print('classifyCalendar $calendarItems');
    for (var element in calendarItems) {
      print(element.summary);
      if (element.summary == 'směsný' || element.summary == 'směsný odpad') {
        mixedCalendarItems.add(element);
        print('Přidáno do mixed');
      } else if (element.summary == 'plast') {
        plasticCalendarItems.add(element);
        print('Přidáno do plastic');
      } else if (element.summary == 'papír') {
        paperCalendarItems.add(element);
        print('Přidáno do paper');
      } else if (element.summary == 'bio' || element.summary == 'bioodpad') {
        bioCalendarItems.add(element);
        print('Přidáno do bio');
      }
    }
    print('clasifyMixed: ${mixedCalendarItems.length}');
    print('clasifyPaper: ${paperCalendarItems.length}');
    print('clasifyPlastic: ${plasticCalendarItems.length}');
    print('clasifyBio: ${bioCalendarItems.length}');
    print('classifyCalendarData complete');
  }

  void createMapOfWasteCalendarData(List wasteCalendar){
  }
}
