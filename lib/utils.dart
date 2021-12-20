import 'dart:collection';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(allWasteEvents);
//final kEvents = _mixedWasteEvents;

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}


/// nakopírování všech Map do jednoho
Map getAllEventsToMap() {
  allWasteEvents.addAll(_mixedWasteEvents);
  allWasteEvents.addAll(_plasticWasteEvents);
  allWasteEvents.addAll(_paperWasteEvents);
  allWasteEvents.addAll(_bioWasteEvents);
  return allWasteEvents;
}

Map<DateTime, List<Event>> allWasteEvents = {};

Map<DateTime, List<Event>> _mixedWasteEvents = {
  DateTime(2022, 1, 12): [const Event('Směsný odpad')],
  DateTime(2022, 2, 9): [const Event('Směsný odpad')],
  DateTime(2022, 3, 9): [const Event('Směsný odpad')],
  DateTime(2022, 4, 6): [const Event('Směsný odpad')],
  DateTime(2022, 5, 4): [const Event('Směsný odpad')],
  DateTime(2022, 6, 1): [const Event('Směsný odpad')],
  DateTime(2022, 6, 29): [const Event('Směsný odpad')],
  DateTime(2022, 7, 27): [const Event('Směsný odpad')],
  DateTime(2022, 8, 24): [const Event('Směsný odpad')],
  DateTime(2022, 9, 21): [const Event('Směsný odpad')],
  DateTime(2022, 10, 19): [const Event('Směsný odpad')],
  DateTime(2022, 11, 16): [const Event('Směsný odpad')],
  DateTime(2022, 12, 14): [const Event('Směsný odpad')],
};

Map<DateTime, List<Event>> _plasticWasteEvents = {
  DateTime(2022, 1, 5): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 1, 19): [const Event('Plast a nápojový karton, Drobné kovy')],
  DateTime(2022, 2, 2): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 2, 16): [const Event('Plast a nápojový karton, Drobné kovy')],
  DateTime(2022, 3, 2): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 3, 16): [const Event('Plast a nápojový karton, Drobné kovy')],
  DateTime(2022, 3, 30): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 4, 13): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 4, 27): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 5, 11): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 5, 25): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 6, 8): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 6, 22): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 7, 6): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 7, 20): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 8, 3): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 8, 17): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 8, 31): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 9, 14): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 9, 28): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 10, 12): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 10, 26): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 11, 9): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 11, 23): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 12, 7): [const Event('Plast a nápojový karton, Drobné kovy'), const Event('Bioodpad')],
  DateTime(2022, 12, 21): [const Event('Plast a nápojový karton, Drobné kovy')],
};

Map<DateTime, List<Event>> _bioWasteEvents = {

};

Map<DateTime, List<Event>> _paperWasteEvents = {
  DateTime(2021, 12, 29): [const Event('Papír')],
  DateTime(2022, 1, 26): [const Event('Papír')],
  DateTime(2022, 2, 23): [const Event('Papír')],
  DateTime(2022, 3, 23): [const Event('Papír')],
  DateTime(2022, 4, 20): [const Event('Papír')],
  DateTime(2022, 5, 18): [const Event('Papír')],
  DateTime(2022, 6, 15): [const Event('Papír')],
  DateTime(2022, 7, 13): [const Event('Papír')],
  DateTime(2022, 8, 10): [const Event('Papír')],
  DateTime(2022, 9, 7): [const Event('Papír')],
  DateTime(2022, 10, 5): [const Event('Papír')],
  DateTime(2022, 11, 2): [const Event('Papír')],
  DateTime(2022, 11, 30): [const Event('Papír')],
  DateTime(2022, 12, 28): [const Event('Papír')],
};

/// Checks if two DateTime objects are the same day.
/// Returns `false` if either of them is null.
bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month && a.day == b.day;
}
