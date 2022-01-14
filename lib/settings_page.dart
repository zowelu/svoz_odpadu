import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/list_tile_of_waste_notification.dart';
import 'package:svoz_odpadu/components/notifications.dart';
import 'package:svoz_odpadu/components/reminder_icon_on_off.dart';
import 'package:svoz_odpadu/components/reminder_time_and_date.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              color: kDBackgroundColorCalendar,
              width: double.infinity,
              height: kDMyAppBarHeight,
              child: const Center(
                child: TextHeader(
                  text: 'Nastavení',
                  color: kDBackgroundColor,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 20,
            fit: FlexFit.tight,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                left: kDMargin,
                right: kDMargin,
                bottom: kDMargin,
              ),
              decoration: const BoxDecoration(
                color: kDBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(children: [Container(
                    padding: const EdgeInsets.all(kDMargin),
                    child: const TextHeader(
                      text: 'Nastavení notikací',
                    ),
                  ),
                    Container(
                      padding: const EdgeInsets.all(kDMargin),
                      child: const TextNormal(
                        text: 'Nastavte si notikace pro jednotlivé druhy odpadů',
                      ),
                    ),],),
                  Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 7,
                            fit: FlexFit.tight,
                            child: ListTileOfWasteNotification(
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
                                            'Plast',
                                            '${Emojis.symbols_red_exclamation_mark} Popelnice  - Plast a nápojový karton + drobné kovy${Emojis.symbols_red_exclamation_mark}',
                                            'Dnes se vyváží popelnice - Plast a nápojový karton + drobné kovy. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
                                            'asset://assets/images/popelnice.jpg');
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
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: FlashBar(
                                              content: const Center(
                                                child: TextNormal(
                                                  text:
                                                      'Chcete zrušit všechny notifikace',
                                                  color: kDBackgroundColor,
                                                ),
                                              ),
                                              title: const Center(
                                                child: TextHeader(
                                                  text: 'Zrušit upozornění',
                                                  color: kDBackgroundColor,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    controller.dismiss();
                                                  },
                                                  child: const TextNormal(
                                                    text: 'Ne',
                                                    color: kDBackgroundColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    cancelScheduledNotifications(
                                                        'Plast');
                                                    setState(
                                                      () {
                                                        activeSheduledReminder =
                                                            false;
                                                        selectedDayGlobal = '';
                                                        selectedTimeOfDayGlobal =
                                                            const TimeOfDay(
                                                                hour: 0,
                                                                minute: 0);
                                                        controller.dismiss();
                                                        showSnackBar(context,
                                                            'Notifikace zrušeny');
                                                        isSwitchedPlastic =
                                                            value;
                                                      },
                                                    );
                                                  },
                                                  child: const TextNormal(
                                                    text:
                                                        'Ano, zrušit notifikace',
                                                    color: kDBackgroundColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                            ),
                          ),
                          IconReminderOnOff(isSwitched: isSwitchedPlastic),
                          ReminderTimeAndDate(
                              switcher: isSwitchedPlastic,
                              wasteReminderTime: plasticReminderTime,
                              wasteReminderDay: plasticSelectedDay),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 7,
                            child: ListTileOfWasteNotification(
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
                                            'Bioodpad',
                                            '${Emojis.symbols_red_exclamation_mark} Popelnice - Bioodpad${Emojis.symbols_red_exclamation_mark}',
                                            'Dnes se vyváží popelnice - Bioodpad. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
                                            'asset://assets/images/popelnice.jpg');
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                                        fontSize:
                                                            kDFontSizeText),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    cancelScheduledNotifications(
                                                        'Bioodpad');
                                                    setState(
                                                      () {
                                                        activeSheduledReminder =
                                                            false;
                                                        selectedDayGlobal = '';
                                                        selectedTimeOfDayGlobal =
                                                            const TimeOfDay(
                                                                hour: 0,
                                                                minute: 0);
                                                        controller.dismiss();
                                                        showSnackBar(context,
                                                            'Notifikace zrušeny');
                                                        isSwitchedBio = value;
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Ano, zrušit notifikace',
                                                    style: TextStyle(
                                                        color:
                                                            kDBackgroundColor,
                                                        fontSize:
                                                            kDFontSizeText,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                            ),
                          ),
                          IconReminderOnOff(isSwitched: isSwitchedBio),
                          ReminderTimeAndDate(
                              switcher: isSwitchedBio,
                              wasteReminderTime: bioReminderTime,
                              wasteReminderDay: bioSelectedDay)
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 7,
                            fit: FlexFit.tight,
                            child: ListTileOfWasteNotification(
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
                                          'Papír',
                                          '${Emojis.symbols_red_exclamation_mark} Popelnice - Papír${Emojis.symbols_red_exclamation_mark}',
                                          'Dnes se vyváží popelnice - Papír. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
                                          'asset://assets/images/popelnice.jpg',
                                        );
                                        showSnackBar(context,
                                            'Notifikace pro Papír byly vytvořeny');
                                        setState(
                                          () {
                                            isSwitchedPaper = value;
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                                        fontSize:
                                                            kDFontSizeText),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    cancelScheduledNotifications(
                                                        'Papír');
                                                    setState(
                                                      () {
                                                        activeSheduledReminder =
                                                            false;
                                                        selectedDayGlobal = '';
                                                        selectedTimeOfDayGlobal =
                                                            const TimeOfDay(
                                                                hour: 0,
                                                                minute: 0);
                                                        controller.dismiss();
                                                        showSnackBar(context,
                                                            'Notifikace zrušeny');
                                                        isSwitchedPaper = value;
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Ano, zrušit notifikace',
                                                    style: TextStyle(
                                                        color:
                                                            kDBackgroundColor,
                                                        fontSize:
                                                            kDFontSizeText,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                            ),
                          ),
                          IconReminderOnOff(isSwitched: isSwitchedPaper),
                          ReminderTimeAndDate(
                              switcher: isSwitchedPaper,
                              wasteReminderTime: paperReminderTime,
                              wasteReminderDay: paperSelectedDay)
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 7,
                            child: ListTileOfWasteNotification(
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
                                          paperWasteEvents,
                                          'Směsný odpad',
                                          '${Emojis.symbols_red_exclamation_mark} Popelnice - Směsný odpad ${Emojis.symbols_red_exclamation_mark}',
                                          'Dnes se vyváží popelnice - Směsný odpad. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
                                          'asset://assets/images/popelnice.jpg',
                                        );
                                        showSnackBar(context,
                                            'Notifikace pro Papír byly vytvořeny');
                                        setState(
                                          () {
                                            isSwitchedMixed = value;
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                                        fontSize:
                                                            kDFontSizeText),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    cancelScheduledNotifications(
                                                        'Směsný odpad');
                                                    setState(
                                                      () {
                                                        activeSheduledReminder =
                                                            false;
                                                        selectedDayGlobal = '';
                                                        selectedTimeOfDayGlobal =
                                                            const TimeOfDay(
                                                                hour: 0,
                                                                minute: 0);
                                                        controller.dismiss();
                                                        showSnackBar(context,
                                                            'Notifikace zrušeny');
                                                        isSwitchedMixed = value;
                                                      },
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Ano, zrušit notifikace',
                                                    style: TextStyle(
                                                        color:
                                                            kDBackgroundColor,
                                                        fontSize:
                                                            kDFontSizeText,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                            ),
                          ),
                          IconReminderOnOff(isSwitched: isSwitchedMixed),
                          ReminderTimeAndDate(
                              switcher: isSwitchedMixed,
                              wasteReminderTime: mixedReminderTime,
                              wasteReminderDay: mixedSelectedDay),
                        ],
                      ),
                    ],
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
                                  text: 'Chcete zrušit všechny notifikace',
                                  color: kDBackgroundColor,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                    cancelScheduledNotifications(
                                        'Směsný odpad');
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
                                        showSnackBar(context,
                                            'Všechny notifikace zrušeny');
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
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
