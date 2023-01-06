/// Slouýí jako položka kalendáře.
class CalendarItem {
  /// Souhrn položky kalendáře.
  final String _summary;

  /// Status položky kalendáře.
  final String _status;

  /// Datum vytvoření položky kalendáře.
  final DateTime _created;

  /// Datum aktualizace položky kalendáře.
  final DateTime _updated;

  /// Datum začátku plánování položky kalendáře.
  final DateTime _start;

  /// Datum konce položky kalendáře.
  final DateTime _end;

  /// Vzorec pro opakování položky kalendáře.
  final String _recurrence;

  /// Url adresa položky kalendáře.
  final String _htmlUrl;

  /// Email tvůrce kalendáře.
  final String _creatorEmail;

  CalendarItem(
      this._summary,
      this._status,
      this._created,
      this._updated,
      this._start,
      this._end,
      this._recurrence,
      this._htmlUrl,
      this._creatorEmail);

  String get summary => _summary;
  String get status => _status;
  DateTime get created => _created;
  DateTime get updated => _updated;
  DateTime get start => _start;
  DateTime get end => _end;
  String get recurrence => _recurrence;
  String get htmlUrl => _htmlUrl;
  String get creatorEmail => _creatorEmail;
}
