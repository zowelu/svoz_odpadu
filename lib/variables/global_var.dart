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

TimeOfDay? plasticReminderTime = TimeOfDay(hour: 0, minute: 0);
int? plasticReminderday;
String? plasticSelectedDay = 'Den Předem';
TimeOfDay? bioReminderTime = TimeOfDay(hour: 0, minute: 0);
int? bioReminderday;
String? bioSelectedDay = 'Den Předem';
TimeOfDay? paperReminderTime = TimeOfDay(hour: 0, minute: 0);
int? paperReminderday;
String? paperSelectedDay = 'Den Předem';
TimeOfDay? mixedReminderTime = TimeOfDay(hour: 0, minute: 0);
int? mixedReminderday;
String? mixedSelectedDay = 'Den Předem';

bool valueCityPickedGlobal = false;
String? valueCityPicked;

String? appVersion;
String? appName;
String? packageName;
String? buildNumber;