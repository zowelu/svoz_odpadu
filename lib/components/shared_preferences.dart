import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

class SharedPreferencesGlobal {
  SharedPreferences? preferences;
  ///initializace SharedPreference
  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  ///načte všechny uložené proměnné
  Future<void> getPreferencesWaste(bool isSwitchedWaste, String isSwitchedWasteString,TimeOfDay? reminderTimeWaste ,String reminderTimeWasteString, String selectedDayWaste) async {
    isSwitchedWaste =
        preferences?.getBool(isSwitchedWasteString) ?? false;

    String timeStamp =
        preferences?.getString(reminderTimeWasteString) ?? '00:00';
    reminderTimeWaste = TimeOfDay(
        hour: (int.parse(timeStamp.split(":")[0])),
        minute: (int.parse(timeStamp.split(":")[1])));
    selectedDayWaste =
        preferences?.getString('plasticSelectedDay') ?? 'V daný den';
    print(
        'load SharedPreferences $reminderTimeWasteString $isSwitchedWaste, $reminderTimeWaste, $selectedDayWaste');
  }

  ///set preferences to stored data for Plastic
  Future<void> setPreferencesWaste(bool isSwitchedWaste, String isSwitchedWasteString,TimeOfDay? reminderTimeWaste ,String reminderTimeWasteString, String selectedDayWaste) async {
    preferences?.setBool(isSwitchedWasteString, isSwitchedWaste);
    String timeStampHour = reminderTimeWaste!.hour.toString();
    String timeStampMinute = reminderTimeWaste.minute.toString();
    preferences?.setString(reminderTimeWasteString, '$timeStampHour:$timeStampMinute');
    preferences?.setString(selectedDayWaste, selectedDayWaste);
    print(
        'Set SharedPreferencesPlastic $isSwitchedWaste, $reminderTimeWaste, $selectedDayWaste');
  }



  Future<void> getPreferencesValueCity() async {
    valueCityPicked =
        preferences?.getString('valueCityPicked');
    print('valueCityPicked from preference homePage: $valueCityPicked');
    if (valueCityPicked == 'Vybrat obec/město') {
      valueCityPickedGlobal = false;
      print('value cityPickedGlobal $valueCityPickedGlobal');
    }else if (valueCityPicked == null) {
      valueCityPickedGlobal = false;
      print('value cityPickedGlobal $valueCityPickedGlobal');
    } else {
      valueCityPickedGlobal = false;
      print('value cityPickedGlobal $valueCityPickedGlobal');
    }
    print('getPreferencesValueCity: $valueCityPicked');
  }
}