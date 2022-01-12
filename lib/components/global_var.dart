import 'package:flutter/material.dart';

bool activeSheduledReminder = false;
String selectedDayGlobal = '';
TimeOfDay selectedTimeOfDayGlobal = const TimeOfDay(hour: 0, minute: 0);
String currentPage = '';

TimeOfDay? plasticReminderTime;
int? plasticReminderday;
TimeOfDay? bioReminderTime;
int? bioReminderday;
TimeOfDay? paperReminderTime;
int? paperReminderday;
TimeOfDay? mixedReminderTime;
int? mixedReminderday;
