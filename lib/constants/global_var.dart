// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

bool activeSheduledReminder = false;
String selectedDayGlobal = '';
TimeOfDay selectedTimeOfDayGlobal = const TimeOfDay(hour: 0, minute: 0);
String currentPage = '';

bool isSwitchedPlastic = false;
bool isSwitchedBio = false;
bool isSwitchedPaper = false;
bool isSwitchedMixed = false;

/*TimeOfDay? plasticReminderTime = TimeOfDay(hour: 00, minute: 00);
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
String? mixedSelectedDay = 'V daný den';*/

TimeOfDay? plasticReminderTime;
int? plasticReminderday;
String? plasticSelectedDay;
TimeOfDay? bioReminderTime;
int? bioReminderday;
String? bioSelectedDay;
TimeOfDay? paperReminderTime;
int? paperReminderday;
String? paperSelectedDay;
TimeOfDay? mixedReminderTime;
int? mixedReminderday;
String? mixedSelectedDay;