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

  Future getCalendarData(String calendarId) async {
    final uri = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=AIzaSyB6op7SkNQjom3XP8sZkwhYkxew3vhdoKg');
    _log.info('uri: $uri');

    var response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Calendar Api error');
    }
    _log.fine('response: ${jsonDecode(response.body)}');
    return jsonDecode(response.body);
  }
}
