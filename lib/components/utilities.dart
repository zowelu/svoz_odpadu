import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/notifications.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/constants/global_var.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;
  final String selectedDay;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.timeOfDay,
    required this.selectedDay
  });
}

Future<NotificationWeekAndTime?> pickSchedule(
  BuildContext context,
) async {
  List<String> day = [
    'V daný den',
    'Den předem',
  ];

  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();
  int selectedDay = 0;

  /*await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Kdy Vás má aplikace upozorňovat?',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 100 * 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int index = 0; index < day.length; index++)
                  ElevatedButton(
                    onPressed: () {
                      selectedDay = index;
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kDBackgroundColor,
                      ),
                    ),
                    child: Text(day[index]),
                  ),
              ],
            ),
          ),
        );
      });*/

  await showFlash(
    context: context,
    builder: (context, controller) {
      return Flash.dialog(
        controller: controller,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        child: FlashBar(
          content: const Center(
            child: TextNormal(
              text: 'Kdy Vás má aplikace upozorňovat?',
              color: kDBackgroundColor,
            ),
          ),
          title: const Center(
            child: TextHeader(
              text: 'Den upozornění',
              color: kDBackgroundColor,
            ),
          ),
          actions: [
            for (int index = 0; index < day.length; index++)
              ElevatedButton(
                onPressed: () {
                  selectedDay = index;
                  controller.dismiss();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    kDBackgroundColor,
                  ),
                ),
                child: Text(day[index]),
              ),
          ],
        ),
      );
    },
  );

  // ignore: unnecessary_null_comparison
  if (selectedDay != null) {
    timeOfDay = await showTimePicker(
        context: context,
        helpText: 'Vyberte čas',
        cancelText: 'Zrušit',
        confirmText: 'Zapnout upozorňování',
        initialTime: TimeOfDay.fromDateTime(
          now.add(
            const Duration(minutes: 1),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    if (timeOfDay != null) {
      //vložení vybraného dne a času do globálních proměnných
      selectedDayGlobal = day[selectedDay].toString();
      selectedTimeOfDayGlobal = timeOfDay;
      return NotificationWeekAndTime(
          dayOfTheWeek: selectedDay, timeOfDay: timeOfDay, selectedDay: day[selectedDay].toString());
    }
  }
  return null;
}

///Nastaví opakované upozorňování ve zvolený den a čas na týdenní bázi
Future<NotificationWeekAndTime?> pickScheduleWeekly(
  BuildContext context,
) async {
  List<String> weekdays = [
    'Pondělí',
    'Úterý',
    'Středa',
    'Čtvrtek',
    'Pátek',
    'Sobota',
    'Neděle',
  ];
  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();
  int? selectedDay;

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Ve který den Vás má aplikace upozorňovat?',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 100 * 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int index = 0; index < weekdays.length; index++)
                  ElevatedButton(
                    onPressed: () {
                      selectedDay = index + 1;
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kDBackgroundColor,
                      ),
                    ),
                    child: Text(weekdays[index]),
                  ),
              ],
            ),
          ),
        );
      });

  if (selectedDay != null) {
    timeOfDay = await showTimePicker(
        context: context,
        helpText: 'Vyberte čas',
        cancelText: 'Zrušit',
        confirmText: 'Zapnout upozorňování',
        initialTime: TimeOfDay.fromDateTime(
          now.add(
            const Duration(minutes: 1),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    if (timeOfDay != null) {
      //vložení vybraného dne a času do globálních proměnných
      selectedDayGlobal = weekdays[selectedDay! - 1].toString();
      selectedTimeOfDayGlobal = timeOfDay;
      return NotificationWeekAndTime(
          dayOfTheWeek: selectedDay!, timeOfDay: timeOfDay, selectedDay: weekdays[selectedDay! - 1].toString());
    }
  }
  return null;
}

Flash? showSnackBar(context, String text) {
  showFlash(
    duration: const Duration(milliseconds: 2500),
    context: context,
    builder: (context, controller) {
      return Flash.bar(
        backgroundColor: kDBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadows: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(-5, 0),
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
        controller: controller,
        child: SizedBox(
            width: double.infinity,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: kDFontSizeText,
                  fontFamily: kDFontFamilyParagraph),
              textAlign: TextAlign.center,
            )),
      );
    },
  );
}

///pomocí cyklu vytvoří notifikace dle Events daného odpadu
void createNotificationReminder(
  NotificationWeekAndTime pickedShedule,
  Map mapOfEventsOfWaste,
  String channelKey,
  String title,
  String body,
  String bigPicture,
) {
  for (int i = 0; i <= mapOfEventsOfWaste.length - 1; i++) {
    int dayOfSelectedEvents =
        mapOfEventsOfWaste.keys.elementAt(i).day - pickedShedule.dayOfTheWeek;
    int monthOfSelectedEvents = mapOfEventsOfWaste.keys.elementAt(i).month;
    int yearOfSelectedEvents = mapOfEventsOfWaste.keys.elementAt(i).year;

    createScheduledReminderNotification(
      pickedShedule,
      channelKey,
      title,
      body,
      bigPicture,
      dayOfSelectedEvents,
      monthOfSelectedEvents,
      yearOfSelectedEvents,
    );
  }
  if (channelKey == 'Plast') {
    plasticReminderTime = pickedShedule.timeOfDay;
    plasticReminderday = pickedShedule.dayOfTheWeek;
    plasticSelectedDay = pickedShedule.selectedDay;
  } else if (channelKey == 'Bioodpad') {
    bioReminderTime = pickedShedule.timeOfDay;
    bioReminderday = pickedShedule.dayOfTheWeek;
    bioSelectedDay = pickedShedule.selectedDay;
  } else if (channelKey == 'Papír') {
    paperReminderTime = pickedShedule.timeOfDay;
    paperReminderday = pickedShedule.dayOfTheWeek;
    paperSelectedDay = pickedShedule.selectedDay;
  } else if (channelKey == 'Směsný odpad') {
    mixedReminderTime = pickedShedule.timeOfDay;
    mixedReminderday = pickedShedule.dayOfTheWeek;
    mixedSelectedDay = pickedShedule.selectedDay;
  }
  // ignore: avoid_print
  print('$mapOfEventsOfWaste, $channelKey, created');
}
