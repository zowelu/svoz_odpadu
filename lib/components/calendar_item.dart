///vytáří objekt
class CalendarItem {
  final String status;
  final String summary;
  final String start;
  final String end;
  final String recurrence;

  CalendarItem(
      {required this.status,
        required this.summary,
        required this.start,
        required this.end,
        this.recurrence = ''});

  /*factory CalendarItem.fromJson(dynamic parsedJson) {
    return CalendarItem(
        summary: parsedJson['summary'],
        start: parsedJson['start']['date'],
        end: parsedJson['end']['date'],
        recurrence: parsedJson['recurrence']);
  }*/
  @override
  String toString() {
    return '{$status, $summary, $start, $end, $recurrence}';
  }
}