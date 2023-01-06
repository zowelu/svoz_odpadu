import 'package:svoz_odpadu/models/calendar_item.dart';

/// Slouží jako model pro kalendář.
class Calendar {
  /// Jméno kalendáře.
  final String _name;

  /// Popis kalendáře.
  final String _description;

  /// Datum aktualizace kalendáře.
  final DateTime _updated;

  /// Potvrzené položky kalendáře.
  final List<CalendarItem> _confirmedItems;

  /// Předběžně potvrzené položky kalendáře,
  final List<CalendarItem> _tentativeItems;

  /// Zrušené položky kalndáře.
  final List<CalendarItem> _cancelledItems;

  Calendar(this._name, this._description, this._updated, this._confirmedItems,
      this._tentativeItems, this._cancelledItems);

  String get name => _name;

  String get description => _description;

  DateTime get updated => _updated;

  List<CalendarItem> get confirmedItems => _confirmedItems;

  List<CalendarItem> get tentativeItems => _tentativeItems;

  List<CalendarItem> get cancelledItems => _cancelledItems;
}
