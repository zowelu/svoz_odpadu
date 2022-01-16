// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

bool activeSheduledReminder = false;
String selectedDayGlobal = '';
TimeOfDay selectedTimeOfDayGlobal = const TimeOfDay(hour: 0, minute: 0);
String currentPage = '';

TimeOfDay? plasticReminderTime = TimeOfDay(hour: 00, minute: 00);
int? plasticReminderday = 0;
String? plasticSelectedDay = 'V daný den';
TimeOfDay? bioReminderTime = TimeOfDay(hour: 00, minute: 00);
int? bioReminderday = 0;
String? bioSelectedDay = 'V daný den';
TimeOfDay? paperReminderTime = TimeOfDay(hour: 00, minute: 00);
int? paperReminderday = 0;
String? paperSelectedDay = 'V daný den';
TimeOfDay? mixedReminderTime = TimeOfDay(hour: 00, minute: 00);
int? mixedReminderday = 0;
String? mixedSelectedDay = 'V daný den';
