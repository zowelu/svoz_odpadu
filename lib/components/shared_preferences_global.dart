// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

class SharedPreferencesGlobal {
  ///initializace SharedPreference
  Future<void> initializePreference() async {
  }

  void getAllPreferenceInMap() async {
    final SharedPreferences? preferences =
        await SharedPreferences.getInstance();
    final Set<String>? keys = preferences?.getKeys();
    final prefsMap = <String, dynamic>{};
    for (String key in keys!) {
      prefsMap[key] = preferences?.get(key);
      print('prefsMap[key]: ${prefsMap[key]}');
    }

    print(prefsMap);
  }

  ///načte všechny uložené proměnné o odpadech
  Future<void> getPreferencesWaste(
      bool isSwitchedWaste,
      String isSwitchedWasteString,
      TimeOfDay? reminderTimeWaste,
      String reminderTimeWasteString,
      String selectedDayWaste) async {
    final SharedPreferences? preferences =
        await SharedPreferences.getInstance();

    isSwitchedWaste = preferences?.getBool(isSwitchedWasteString) ?? false;

    String timeStamp =
        preferences?.getString(reminderTimeWasteString) ?? '00:00';

    reminderTimeWaste = TimeOfDay(
        hour: (int.parse(timeStamp.split(":")[0])),
        minute: (int.parse(timeStamp.split(":")[1])));

    selectedDayWaste =
        preferences?.getString('plasticSelectedDay') ?? 'V daný den';

    if (isSwitchedWasteString == 'isSwitchedPlastic') {
      isSwitchedPlastic = isSwitchedWaste;
      plasticReminderTime = reminderTimeWaste;
      plasticSelectedDay = selectedDayWaste;
    } else if (isSwitchedWasteString == 'isSwitchedBio') {
      isSwitchedBio = isSwitchedWaste;
      bioReminderTime = reminderTimeWaste;
      bioSelectedDay = selectedDayWaste;
    } else if (isSwitchedWasteString == 'isSwitchedPaper') {
      isSwitchedPaper = isSwitchedWaste;
      paperReminderTime = reminderTimeWaste;
      paperSelectedDay = selectedDayWaste;
    } else if (isSwitchedWasteString == 'isSwitchedMixed') {
      isSwitchedMixed = isSwitchedWaste;
      mixedReminderTime = reminderTimeWaste;
      mixedSelectedDay = selectedDayWaste;
    }

    print(
        'load SharedPreferences $reminderTimeWasteString $isSwitchedWaste, $reminderTimeWaste, $selectedDayWaste');
  }

  ///set preferences to stored data for Plastic
  Future<void> setPreferencesWaste(
      bool isSwitchedWaste,
      String isSwitchedWasteString,
      TimeOfDay? reminderTimeWaste,
      String reminderTimeWasteString,
      String selectedDayWaste) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(isSwitchedWasteString, isSwitchedWaste);
    String timeStampHour = reminderTimeWaste!.hour.toString();
    String timeStampMinute = reminderTimeWaste.minute.toString();
    preferences.setString(
        reminderTimeWasteString, '$timeStampHour:$timeStampMinute');
    preferences.setString(selectedDayWaste, selectedDayWaste);
    print(
        'Set SharedPreferencesPlastic $isSwitchedWaste, $reminderTimeWaste, $selectedDayWaste');
  }
  ///přečte valueCityPicked z preferencí, přiřadí název proměnné $valueCityPicked a zvolí bool valueCityPickedBool
  Future<void> getPreferencesValueCity() async {
    final SharedPreferences? preferences =
        await SharedPreferences.getInstance();
    valueCityPicked = preferences?.getString('valueCityPicked') ?? 'Vybrat obec/město';
    print('valueCityPicked from preference LoadingPage: $valueCityPicked');
    if (valueCityPicked == 'Vybrat obec/město' || valueCityPicked == null) {
      valueCityPickedGlobal = false;
      print('value cityPickedGlobal $valueCityPickedGlobal');
    } else {
      valueCityPickedGlobal = true;
      print('value cityPickedGlobal $valueCityPickedGlobal');
    }
  }

  Future<void> setPreferencesValueCity(
      String valueCityPicked, String valueCityPickedString) async {
    final SharedPreferences? preferences =
        await SharedPreferences.getInstance();
    preferences!.setString(valueCityPickedString, valueCityPicked);
  }

  void setPreferenceReminder()async{
    final SharedPreferences? preferences =
        await SharedPreferences.getInstance();
    preferences!.setBool('isSetReminder', isSetReminder);
    String timeStampHour = setReminderTime!.hour.toString();
    String timeStampMinute = setReminderTime!.minute.toString();
    preferences.setString(
        'setReminderTimeString', '$timeStampHour:$timeStampMinute');
    preferences.setString('setReminderDateString', setReminderDate!);
    print(
        'Set setPreferenceReminder $isSetReminder, $setReminderTime, $setReminderDate');
  }

  void getPreferenceReminder()async{
    final SharedPreferences? preferences =
    await SharedPreferences.getInstance();

    isSetReminder = preferences?.getBool('isSetReminder') ?? false;

    String timeStamp =
        preferences?.getString('setReminderTimeString') ?? '00:00';

    setReminderTime = TimeOfDay(
        hour: (int.parse(timeStamp.split(":")[0])),
        minute: (int.parse(timeStamp.split(":")[1])));

    setReminderDate =
        preferences?.getString('setReminderDateString') ?? 'V daný den';


    print(
        'load SharedPreferences Reminder $isSetReminder $setReminderTime, $setReminderDate');
  }
}
