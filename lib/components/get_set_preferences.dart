import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

class GetSetPreferences{
  SharedPreferences? preferences;

  ///get preferences from stored data for Waste
  Future<void> getPreferencesWaste(bool? isSwitched, String isSwitchedString, String reminderTimeString, String? selectedDayString) async {
    isSwitched = preferences?.getBool(isSwitchedString) ?? false;
    String timeStamp = preferences?.getString(reminderTimeString) ?? '00:00';
    plasticReminderTime = TimeOfDay(
        hour: (int.parse(timeStamp.split(":")[0])),
        minute: (int.parse(timeStamp.split(":")[1])));
    plasticSelectedDay = preferences?.getString(selectedDayString!) ?? 'V daný den';
    print(
        'load SharedPreferencesPlastic $isSwitchedPlastic, $plasticReminderTime, $plasticSelectedDay');
  }

}
