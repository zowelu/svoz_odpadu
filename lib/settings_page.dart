import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/list_tile_of_waste_notification.dart';
import 'package:svoz_odpadu/components/notifications.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svoz_odpadu/components/utilities.dart';
import 'package:svoz_odpadu/components/button_settings.dart';
import 'package:svoz_odpadu/components/global_var.dart';
import 'package:flash/flash.dart';
import 'package:svoz_odpadu/components/utils.dart';

class SettingsPage extends StatefulWidget {
  static const id = '/settingsPage';

  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitchedPlastic = false;
  bool isSwitchedBio = false;
  bool isSwitchedPaper = false;
  bool isSwitchedMixed = false;

  @override
  void initState() {
    super.initState();
    currentPage = 'settings';
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('cs');
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kDMyAppBarHeight),
        child: MyAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            color: kDBackgroundColorCalendar,
            width: double.infinity,
            height: kDMyAppBarHeight,
            child: const Center(
              child: TextHeader(text: 'Nastavení'),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kDBackgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.all(kDMargin),
                    child: const Text(
                      'Nastavení notikací',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: kDFontFamilyHeader,
                          fontSize: kDFontSizeHeader),
                      textAlign: TextAlign.center,
                    )),
                Container(
                    padding: const EdgeInsets.all(kDMargin),
                    child: const Text(
                      'Nastavte si notikace pro jednotlivé druhy odpadů',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: kDFontFamilyParagraph,
                          fontSize: kDFontSizeText),
                      textAlign: TextAlign.center,
                    )),
                ListTileOfWasteNotification(
                  text: 'Plast a nápojový karton\nDrobné kovy',
                  color: kDColorWastePlastic,
                  valueOfSwitch: isSwitchedPlastic,
                  onChanged: !isSwitchedPlastic
                      ? (value) async {
                          NotificationWeekAndTime? pickedShedule =
                              await pickSchedule(context);
                          if (pickedShedule != null) {
                            createNotificationReminder(
                                pickedShedule,
                                plasticWasteEvents,
                                createScheduledReminderNotificationPlastic);
                            showSnackBar(context,
                                'Notifikace pro Plast a nápojový karton + Drobné kovy byly vytvořeny');
                            setState(
                              () {
                                isSwitchedPlastic = value;
                              },
                            );
                          }
                        }
                      : (value) async {
                          showFlash(
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
                                        text:
                                            'Chcete zrušit všechny notifikace'),
                                  ),
                                  title: const Center(
                                    child: TextHeader(
                                      text: 'Zrušit upozornění',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        controller.dismiss();
                                      },
                                      child: const Text(
                                        'Ne',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: kDFontSizeText),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        cancelScheduledNotifications('Plast');
                                        setState(
                                          () {
                                            activeSheduledReminder = false;
                                            selectedDayGlobal = '';
                                            selectedTimeOfDayGlobal =
                                                const TimeOfDay(
                                                    hour: 0, minute: 0);
                                            controller.dismiss();
                                            showSnackBar(
                                                context, 'Notifikace zrušeny');
                                            isSwitchedPlastic = value;
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Ano, zrušit notifikace',
                                        style: TextStyle(
                                            color: kDBackgroundColor,
                                            fontSize: kDFontSizeText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                ),
                ListTileOfWasteNotification(
                  text: 'Bioodpad',
                  color: kDColorWasteBio,
                  valueOfSwitch: isSwitchedBio,
                  onChanged: !isSwitchedBio
                      ? (value) async {
                          NotificationWeekAndTime? pickedShedule =
                              await pickSchedule(context);
                          if (pickedShedule != null) {

                            createNotificationReminder(
                                pickedShedule,
                                bioWasteEvents,
                                createScheduledReminderNotificationBio);
                            showSnackBar(context,
                                'Notifikace pro Bioodpad byly vytvořeny');
                            setState(
                                  () {
                                isSwitchedBio = value;
                              },
                            );
                          }
                        }
                      : (value) async {
                          showFlash(
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
                                        text:
                                            'Chcete zrušit všechny notifikace'),
                                  ),
                                  title: const Center(
                                    child: TextHeader(
                                      text: 'Zrušit upozornění',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        controller.dismiss();
                                      },
                                      child: const Text(
                                        'Ne',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: kDFontSizeText),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        cancelScheduledNotifications(
                                            'Bioodpad');
                                        setState(
                                          () {
                                            activeSheduledReminder = false;
                                            selectedDayGlobal = '';
                                            selectedTimeOfDayGlobal =
                                                const TimeOfDay(
                                                    hour: 0, minute: 0);
                                            controller.dismiss();
                                            showSnackBar(
                                                context, 'Notifikace zrušeny');
                                            isSwitchedBio = value;
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Ano, zrušit notifikace',
                                        style: TextStyle(
                                            color: kDBackgroundColor,
                                            fontSize: kDFontSizeText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                ),
                ListTileOfWasteNotification(
                  text: 'Papír',
                  color: kDColorWastePaper,
                  valueOfSwitch: isSwitchedPaper,
                  onChanged: !isSwitchedPaper
                      ? (value) async {
                          NotificationWeekAndTime? pickedShedule =
                              await pickSchedule(context);
                          if (pickedShedule != null) {

                            createNotificationReminder(
                                pickedShedule,
                                paperWasteEvents,
                                createScheduledReminderNotificationPaper);
                            showSnackBar(
                                context, 'Notifikace pro Papír byly vytvořeny');
                            setState(
                                  () {
                                isSwitchedPaper= value;
                              },
                            );
                          }

                        }
                      : (value) async {
                          showFlash(
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
                                        text:
                                            'Chcete zrušit všechny notifikace'),
                                  ),
                                  title: const Center(
                                    child: TextHeader(
                                      text: 'Zrušit upozornění',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        controller.dismiss();
                                      },
                                      child: const Text(
                                        'Ne',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: kDFontSizeText),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        cancelScheduledNotifications('Papír');
                                        setState(
                                          () {
                                            activeSheduledReminder = false;
                                            selectedDayGlobal = '';
                                            selectedTimeOfDayGlobal =
                                                const TimeOfDay(
                                                    hour: 0, minute: 0);
                                            controller.dismiss();
                                            showSnackBar(
                                                context, 'Notifikace zrušeny');
                                            isSwitchedPaper = value;
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Ano, zrušit notifikace',
                                        style: TextStyle(
                                            color: kDBackgroundColor,
                                            fontSize: kDFontSizeText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                ),
                ListTileOfWasteNotification(
                  text: 'Směsný odpad',
                  color: kDColorWasteMixed,
                  valueOfSwitch: isSwitchedMixed,
                  onChanged: !isSwitchedMixed
                      ? (value) async {
                          NotificationWeekAndTime? pickedShedule =
                              await pickSchedule(context);
                          if (pickedShedule != null) {
                            createNotificationReminder(
                                pickedShedule,
                                mixedWasteEvents,
                                createScheduledReminderNotificationMixed);
                            showSnackBar(
                                context, 'Notifikace pro Papír byly vytvořeny');
                            setState(
                                  () {
                                isSwitchedMixed= value;
                              },
                            );
                          }
                          showSnackBar(context,
                              'Notifikace pro Směsný odpad byly vytvořeny');
                        }
                      : (value) async {
                          showFlash(
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
                                        text:
                                            'Chcete zrušit všechny notifikace'),
                                  ),
                                  title: const Center(
                                    child: TextHeader(
                                      text: 'Zrušit upozornění',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        controller.dismiss();
                                      },
                                      child: const Text(
                                        'Ne',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: kDFontSizeText),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        cancelScheduledNotifications(
                                            'Směsný odpad');
                                        setState(
                                          () {
                                            activeSheduledReminder = false;
                                            selectedDayGlobal = '';
                                            selectedTimeOfDayGlobal =
                                                const TimeOfDay(
                                                    hour: 0, minute: 0);
                                            controller.dismiss();
                                            showSnackBar(
                                                context, 'Notifikace zrušeny');
                                            isSwitchedMixed = value;
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Ano, zrušit notifikace',
                                        style: TextStyle(
                                            color: kDBackgroundColor,
                                            fontSize: kDFontSizeText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ButtonSettings(
                onTap: () async {
                  NotificationWeekAndTime? pickedShedule =
                      await pickScheduleWeekly(context);

                  if (pickedShedule != null) {
                    createScheduledReminderNotification(pickedShedule);
                    showSnackBar(
                        context, 'Notifikace nastaveny na každý týden');
                  }
                  setState(() {
                    activeSheduledReminder = true;
                  });
                },
                title: 'Nastavit obecné upozornění',
                subtitle:
                    'Nastavíte upozornění na zvolený den a čas každý týden',
                icon: Icons.notifications,
              ),
              const SizedBox(
                height: 5,
              ),
              ButtonSettings(
                onTap: () {
                  showFlash(
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
                                text: 'Chcete zrušit všechny notifikace'),
                          ),
                          title: const Center(
                            child: TextHeader(
                              text: 'Zrušit upozornění',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                controller.dismiss();
                              },
                              child: const Text(
                                'Ne',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: kDFontSizeText),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                cancelScheduledNotificationsAll();
                                cancelScheduledNotifications('Směsný odpad');
                                cancelScheduledNotifications('Papír');
                                cancelScheduledNotifications('Bioodpad');
                                cancelScheduledNotifications('Plast');
                                setState(
                                  () {
                                    activeSheduledReminder = false;
                                    selectedDayGlobal = '';
                                    selectedTimeOfDayGlobal =
                                        const TimeOfDay(hour: 0, minute: 0);
                                    controller.dismiss();
                                    showSnackBar(
                                        context, 'Všechny notifikace zrušeny');
                                    isSwitchedPlastic = false;
                                    isSwitchedMixed = false;
                                    isSwitchedPaper = false;
                                    isSwitchedBio = false;
                                  },
                                );
                              },
                              child: const Text(
                                'Ano, zrušit notifikace',
                                style: TextStyle(
                                    color: kDBackgroundColor,
                                    fontSize: kDFontSizeText,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  cancelScheduledNotificationsAll();
                },
                title: 'Zrušit upozornění',
                subtitle: 'Zrušíte všechna nastavená upozornění',
                icon: Icons.notifications_off,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              activeSheduledReminder
                  ? Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          color: Colors.redAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        children: [
                          const Text(
                            'Máte zapnuté upozorňování každý týden v:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: kDFontFamilyParagraph,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '$selectedDayGlobal v ${selectedTimeOfDayGlobal.toString().replaceAll('TimeOfDay', '').replaceAll('(', '').replaceAll(')', '')}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: kDFontFamilyParagraph,
                              fontSize: kDFontSizeText,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Text(''),
            ],
          ),
        ],
      ),
    );
  }
}
