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

bool valueCityPickedGlobal = false;
String? valueCityPicked;