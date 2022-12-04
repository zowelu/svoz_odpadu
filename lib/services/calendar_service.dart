import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class CalendarService {
  final Logger _log = Logger('CalendarService');
  Map<String, String> calendarId = {
    'mixed': 'go5dkg6cnflo277vhc6cbemt3k@group.calendar.google.com',
    'plastic': 'go5dkg6cnflo277vhc6cbemt3k@group.calendar.google.com',
    'paper': 'p7g0np51igvv0bko1bf4nmtmf0@group.calendar.google.com',
    'bio': 'bnjcsj8qmn2guo40789odlvrvo@group.calendar.google.com'
  };

  /// Vrátí všechny
  Future<List<Map<String, dynamic>>> getCalendarConfirmedData() async {
    /// List položek kalendáře se statusem 'confirmed'.
    List<Map<String, dynamic>> confirmedItems = [];
    for (String calendarId in calendarId.values) {
      final uri = Uri.parse(
          'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=AIzaSyB6op7SkNQjom3XP8sZkwhYkxew3vhdoKg');
      _log.info('uri: $uri');

      // získá odpověď ze serveru
      var response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Calendar Api error');
      }
      // dekóduje data do Map
      Map<String, dynamic>? responseData = jsonDecode(response.body);
      if (responseData != null) {
        // z dat vytáhne jen Items
        List? responseDataItems = responseData['items'];
        if (responseDataItems != null) {
          for (var item in responseDataItems) {
            if (item['status'] == 'confirmed') {
              confirmedItems.add(item);
            }
          }
        }
      }
    }
    return confirmedItems;
  }

  /* void sort*/
}
