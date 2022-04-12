import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/notifications.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';
import 'package:package_info_plus/package_info_plus.dart';

///vytvoří unikátní ID
int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

///objekt NotificationWeekAndTime
class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;
  final String selectedDay;

  NotificationWeekAndTime(
      {required this.dayOfTheWeek,
      required this.timeOfDay,
      required this.selectedDay});
}

///zobrazí dialog na vybrání dne a poté času
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
      isSetReminder = true;
      setReminderTime = timeOfDay;
      setReminderDate = day[selectedDay].toString();
      return NotificationWeekAndTime(
          dayOfTheWeek: selectedDay,
          timeOfDay: timeOfDay,
          selectedDay: day[selectedDay].toString());
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
  return null;
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

///zjistí verzi aplikace z pubspec
Future getPackageInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  WidgetsFlutterBinding.ensureInitialized();
  appVersion = packageInfo.version;
  appName = packageInfo.appName;
  packageName = packageInfo.packageName;
  buildNumber = packageInfo.buildNumber;
}
