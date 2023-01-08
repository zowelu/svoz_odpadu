import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:svoz_odpadu/models/calendar.dart';
import 'package:svoz_odpadu/models/calendar_item.dart';

class CalendarService {
  final Logger _log = Logger('CalendarService');

  /// Vytvoří [calendar] na základě získaných dat.
  Future<Calendar?> getCalendarData(String calendarId) async {
    Calendar? calendar;

    // Uri adresa kalendáře.
    final uri = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/$calendarId/events?key=AIzaSyB6op7SkNQjom3XP8sZkwhYkxew3vhdoKg');
    _log.info('uri: $uri');

    try {
      // Získá odpověď ze serveru.
      var response = await http.get(uri);
      // Dekóduje data do Map.
      Map<String, dynamic>? responseData = jsonDecode(response.body);
      if (responseData != null) {
        /// Jméno kalendáře.
        String? name = responseData['summary'];

        /// Popis kalendáře.
        String? description = responseData['description'];

        /// Datum aktualizace kalendáře.
        DateTime? updated = serializeDateTime(responseData['updated']);

        /// Položky kalendáře.
        List<dynamic>? items = responseData['items'];

        /// Potvrzené položky kalendáře.
        List<CalendarItem> confirmedItems = [];

        /// Předběžně potvrzené položky kalendáře,
        List<CalendarItem> tentativeItems = [];

        /// Zrušené položky kalndáře.
        List<CalendarItem> cancelledItems = [];

        if (items != null) {
          for (var item in items) {
            /// Zobrazované jméno položky kalendáře.
            String displayName = item['organizer']['displayName'];

            /// Souhrn položky kalendáře.
            String summary = item['summary'];

            /// Status položky kalendáře.
            String status = item['status'];

            /// Datum vytvoření položky kalendáře.
            DateTime? createdItem = serializeDateTime(item['created']);

            /// Datum aktualizace položky kalendáře.
            DateTime? updated = serializeDateTime(item['updated']);

            /// Datum začátku plánování položky kalendáře.
            DateTime? start = serializeDateTime(item['start']['date']);

            /// Datum konce položky kalendáře.
            DateTime? end = serializeDateTime(item['end']['date']);

            /// Vzorec pro opakování položky kalendáře.
            List recurrence = item['recurrence'];

            /// Url adresa položky kalendáře.
            String htmlUrl = item['htmlLink'];

            /// Email tvůrce kalendáře.
            String creatorEmail = item['creator']['email'];

            CalendarItem calendarItem = CalendarItem(
                displayName,
                summary,
                status,
                createdItem,
                updated,
                start,
                end,
                recurrence,
                htmlUrl,
                creatorEmail);

            switch (status) {
              case 'confirmed':
                {
                  confirmedItems.add(calendarItem);
                }
                break;
              case 'tentative':
                {
                  tentativeItems.add(calendarItem);
                }
                break;
              case 'cancelled':
                {
                  cancelledItems.add(calendarItem);
                }
                break;
            }
          }

          if (name != null || description != null) {
            calendar = Calendar(name!, description!, updated, confirmedItems,
                tentativeItems, cancelledItems);
          }
        }
      }
      return calendar;
    } catch (e) {
      throw Exception('Calendar Api error. Error: $e');
    }
  }

  DateTime serializeDateTime(String dateTimeString) {
    int dateTimeStringLength = dateTimeString.length;
    String? dateTimeStringEdited;
    DateTime dateTime = DateTime(0);
    if (dateTimeStringLength > 10) {
      if (dateTimeString != null) {
        dateTimeStringEdited =
            dateTimeString.substring(0, dateTimeString.length - 1);
        if (dateTimeStringEdited != null) {
          dateTime = DateTime.parse(dateTimeStringEdited);
        }
      }
    } else {
      dateTime = DateTime.parse(dateTimeString);
    }

    return dateTime;
  }
}
