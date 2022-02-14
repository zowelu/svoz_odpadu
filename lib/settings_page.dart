// ignore_for_file: unnecessary_this, avoid_print
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/list_tile_of_waste_notification.dart';
import 'package:svoz_odpadu/components/notifications.dart';
import 'package:svoz_odpadu/components/shared_preferences_global.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svoz_odpadu/components/utilities.dart';
import 'package:flash/flash.dart';
import 'package:svoz_odpadu/components/utils.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

class SettingsPage extends StatefulWidget {
  static const id = '/settingsPage';

  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SharedPreferencesGlobal sharedPreferencesGlobal = SharedPreferencesGlobal();

  ///načte všechny uložené preference
  Future<void> getPreferencesAll() async {
    sharedPreferencesGlobal.getPreferencesWaste(
        isSwitchedPlastic,
        'isSwitchedPlastic',
        plasticReminderTime,
        'plasticReminderTime',
        plasticSelectedDay!);
    sharedPreferencesGlobal.getPreferencesWaste(isSwitchedBio, 'isSwitchedBio',
        bioReminderTime, 'bioReminderTime', bioSelectedDay!);
    sharedPreferencesGlobal.getPreferencesWaste(
        isSwitchedPaper,
        'isSwitchedPaper',
        paperReminderTime,
        'paperReminderTime',
        paperSelectedDay!);
    sharedPreferencesGlobal.getPreferencesWaste(
        isSwitchedMixed,
        'isSwitchedMixed',
        mixedReminderTime,
        'mixedReminderTime',
        mixedSelectedDay!);
  }

  /// uložím všechny preference
  Future<void> setPreferencesAll() async {
    sharedPreferencesGlobal.setPreferencesWaste(
        isSwitchedPlastic,
        'isSwitchedPlastic',
        plasticReminderTime,
        'plasticReminderTime',
        plasticSelectedDay!);
    sharedPreferencesGlobal.setPreferencesWaste(isSwitchedBio, 'isSwitchedBio',
        bioReminderTime, 'bioReminderTime', bioSelectedDay!);
    sharedPreferencesGlobal.setPreferencesWaste(
        isSwitchedPaper,
        'isSwitchedPaper',
        paperReminderTime,
        'paperReminderTime',
        paperSelectedDay!);
    sharedPreferencesGlobal.setPreferencesWaste(
        isSwitchedMixed,
        'isSwitchedMixed',
        mixedReminderTime,
        'mixedReminderTime',
        mixedSelectedDay!);
  }

  @override
  void initState() {
    super.initState();
    currentPage = SettingsPage.id;
    sharedPreferencesGlobal.initializePreference().whenComplete(() {
      setState(() {
        getPreferencesAll();
        sharedPreferencesGlobal.getPreferenceReminder();
      });
    });
  }

  @override
  void dispose() {
    currentPage = SettingsPage.id;
    sharedPreferencesGlobal.setPreferenceReminder();
    setPreferencesAll();
    super.dispose();
  }

  void update() {
    setState(() {
      sharedPreferencesGlobal.getPreferencesWaste(
          isSwitchedPlastic,
          'isSwitchedPlastic',
          plasticReminderTime,
          'plasticReminderTime',
          plasticSelectedDay!);
      sharedPreferencesGlobal.getPreferencesWaste(isSwitchedBio,
          'isSwitchedBio', bioReminderTime, 'bioReminderTime', bioSelectedDay!);
      sharedPreferencesGlobal.getPreferencesWaste(
          isSwitchedPaper,
          'isSwitchedPaper',
          paperReminderTime,
          'paperReminderTime',
          paperSelectedDay!);
      sharedPreferencesGlobal.getPreferencesWaste(
          isSwitchedMixed,
          'isSwitchedMixed',
          mixedReminderTime,
          'mixedReminderTime',
          mixedSelectedDay!);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('cs');
    update();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
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
              Container(
                padding: const EdgeInsets.all(kDMargin),
                child: const TextHeader(
                  text: 'Nastavení notikací',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(kDMargin),
                child: const TextNormal(text: 'Nejprve si nastavte den a čas'),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: kDBackgroundColorCalendar,
                    borderRadius: kDRadiusLarge),
                padding: const EdgeInsets.only(
                    top: 2.0,
                    bottom: 2.0,
                    left: kDMarginLarger,
                    right: kDMarginLarger),
                margin: const EdgeInsets.only(left: kDMargin, right: kDMargin),
                child: Column(
                  children: [
                    Container(
                        child: !isSetReminder
                            ? const TextHeader(
                                text: 'Vypnuto',
                                color: Colors.grey,
                              )
                            : const TextHeader(
                                text: 'Zapnuto',
                                color: Colors.red,
                              )),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: TextNormal(
                              text: isSetReminder
                                  ? '${setReminderTime!.hour}: ${setReminderTime!.minute}'
                                  : '',
                              color: kDBackgroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: TextNormal(
                                text: isSetReminder ? '$setReminderDate' : '',
                                color: kDBackgroundColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Switch(
                            value: isSetReminder,
                            onChanged: !isSetReminder
                                ? (value) async {
                                    NotificationWeekAndTime? pickedShedule =
                                        await pickSchedule(context);
                                    if (pickedShedule != null) {
                                      showSnackBar(context,
                                          'Upozorňování zapnuta v $setReminderDate v ${setReminderTime!.hour}:${setReminderTime!.minute}');
                                      setState(
                                        () {
                                          isSetReminder = value;
                                          pickedSheduleVar = pickedShedule;
                                          sharedPreferencesGlobal
                                              .setPreferenceReminder();
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
                                                  cancelScheduledNotificationsAll();
                                                  setState(
                                                    () {
                                                      controller.dismiss();
                                                      showSnackBar(context,
                                                          'Notifikace zrušeny');
                                                      isSetReminder = value;

                                                      isSwitchedPlastic = value;
                                                      isSwitchedPaper = value;
                                                      isSwitchedBio = value;
                                                      isSwitchedMixed = value;
                                                      sharedPreferencesGlobal
                                                          .setPreferencesWaste(
                                                              isSwitchedPlastic,
                                                              'isSwitchedPlastic',
                                                              plasticReminderTime,
                                                              'plasticReminderTime',
                                                              plasticSelectedDay!);
                                                      sharedPreferencesGlobal
                                                          .setPreferencesWaste(
                                                              isSwitchedPaper,
                                                              'isSwitchedPaper',
                                                              paperReminderTime,
                                                              'paperReminderTime',
                                                              plasticSelectedDay!);
                                                      sharedPreferencesGlobal
                                                          .setPreferencesWaste(
                                                              isSwitchedBio,
                                                              'isSwitchedBio',
                                                              bioReminderTime,
                                                              'bioReminderTime',
                                                              bioSelectedDay!);
                                                      sharedPreferencesGlobal
                                                          .setPreferencesWaste(
                                                              isSwitchedMixed,
                                                              'isSwitchedMixed',
                                                              mixedReminderTime,
                                                              'mixedReminderTime',
                                                              mixedSelectedDay!);
                                                      sharedPreferencesGlobal
                                                          .setPreferenceReminder();
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
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(kDMargin),
                child: const Center(
                  child: TextNormal(
                    text: 'Nastavte si notikace pro jednotlivé druhy odpadů',
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: kDBackgroundColorCalendar,
                    borderRadius: kDRadiusLarge),
                padding: const EdgeInsets.all(2.0),
                margin: const EdgeInsets.only(left: kDMargin, right: kDMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTileOfWasteNotification(
                      text: 'Plast a nápojový karton\nDrobné kovy',
                      color: kDColorWastePlastic,
                      valueOfSwitch: isSwitchedPlastic,
                      onChanged: !isSwitchedPlastic
                          ? (value) async {
                              if (isSetReminder != false) {
                                createNotificationReminder(
                                    pickedSheduleVar!,
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
                                    sharedPreferencesGlobal.setPreferencesWaste(
                                        isSwitchedPlastic,
                                        'isSwitchedPlastic',
                                        plasticReminderTime,
                                        'plasticReminderTime',
                                        plasticSelectedDay!);
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
                                                controller.dismiss();
                                                showSnackBar(context,
                                                    'Notifikace zrušeny');
                                                isSwitchedPlastic = value;
                                                sharedPreferencesGlobal
                                                    .setPreferencesWaste(
                                                        isSwitchedPlastic,
                                                        'isSwitchedplastic',
                                                        plasticReminderTime,
                                                        'plasticReminderTime',
                                                        plasticSelectedDay!);
                                              },
                                            );
                                          },
                                          child: const TextNormal(
                                            text: 'Ano, zrušit notifikace',
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
                      wasteReminderTime: plasticReminderTime!,
                      wasteSelectedDay: plasticSelectedDay!,
                    ),
                    ListTileOfWasteNotification(
                      text: 'Bioodpad',
                      color: kDColorWasteBio,
                      valueOfSwitch: isSwitchedBio,
                      onChanged: !isSwitchedBio
                          ? (value) async {
                              if (isSetReminder != false) {
                                createNotificationReminder(
                                    pickedSheduleVar!,
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
                                    sharedPreferencesGlobal.setPreferencesWaste(
                                        isSwitchedBio,
                                        'isSwitchedBio',
                                        bioReminderTime,
                                        'bioReminderTime',
                                        bioSelectedDay!);
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
                                                controller.dismiss();
                                                showSnackBar(context,
                                                    'Notifikace zrušeny');
                                                isSwitchedBio = value;
                                                sharedPreferencesGlobal
                                                    .setPreferencesWaste(
                                                        isSwitchedBio,
                                                        'isSwitchedBio',
                                                        bioReminderTime,
                                                        'bioReminderTime',
                                                        bioSelectedDay!);
                                                //setPreferencesBio();
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
                      wasteReminderTime: bioReminderTime!,
                      wasteSelectedDay: bioSelectedDay!,
                    ),
                    ListTileOfWasteNotification(
                      text: 'Papír',
                      color: kDColorWastePaper,
                      valueOfSwitch: isSwitchedPaper,
                      onChanged: !isSwitchedPaper
                          ? (value) async {
                              if (isSetReminder != false) {
                                createNotificationReminder(
                                  pickedSheduleVar!,
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
                                    sharedPreferencesGlobal.setPreferencesWaste(
                                        isSwitchedPaper,
                                        'isSwitchedPaper',
                                        paperReminderTime,
                                        'paperReminderTime',
                                        paperSelectedDay!);
                                    //setPreferencesPaper();
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
                                                'Papír');
                                            setState(
                                              () {
                                                controller.dismiss();
                                                showSnackBar(context,
                                                    'Notifikace zrušeny');
                                                isSwitchedPaper = value;
                                                sharedPreferencesGlobal
                                                    .setPreferencesWaste(
                                                        isSwitchedPaper,
                                                        'isSwitchedPaper',
                                                        paperReminderTime,
                                                        'paperReminderTime',
                                                        paperSelectedDay!);
                                                //setPreferencesPaper();
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
                      wasteReminderTime: paperReminderTime!,
                      wasteSelectedDay: paperSelectedDay!,
                    ),
                    ListTileOfWasteNotification(
                      text: 'Směsný odpad',
                      color: kDColorWasteMixed,
                      valueOfSwitch: isSwitchedMixed,
                      onChanged: !isSwitchedMixed
                          ? (value) async {
                              if (isSetReminder != false) {
                                createNotificationReminder(
                                  pickedSheduleVar!,
                                  mixedWasteEvents,
                                  'Směsný odpad',
                                  '${Emojis.symbols_red_exclamation_mark} Popelnice - Směsný odpad ${Emojis.symbols_red_exclamation_mark}',
                                  'Dnes se vyváží popelnice - Směsný odpad. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
                                  'asset://assets/images/popelnice.jpg',
                                );
                                showSnackBar(context,
                                    'Notifikace pro Směsný odpad byly vytvořeny');
                                setState(
                                  () {
                                    isSwitchedMixed = value;
                                    sharedPreferencesGlobal.setPreferencesWaste(
                                        isSwitchedMixed,
                                        'isSwitchedMixed',
                                        mixedReminderTime,
                                        'mixedReminderTime',
                                        mixedSelectedDay!);
                                    //setPreferencesMixed();
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
                                                controller.dismiss();
                                                showSnackBar(context,
                                                    'Notifikace zrušeny');
                                                isSwitchedMixed = value;
                                                sharedPreferencesGlobal
                                                    .setPreferencesWaste(
                                                        isSwitchedMixed,
                                                        'isSwitchedMixed',
                                                        mixedReminderTime,
                                                        'mixedReminderTime',
                                                        mixedSelectedDay!);
                                                //setPreferencesMixed();
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
                      wasteReminderTime: mixedReminderTime!,
                      wasteSelectedDay: mixedSelectedDay!,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: const [
              /*ButtonSettings(
                    color: Colors.blueGrey,
                    onTap: () {
                      Navigator.pushNamed(context, CityPickerPage.id);
                    },
                    title: 'Vybrat obec/město svozu',
                    subtitle: 'Vyberete si své město',
                    icon: Icons.apartment_outlined),*/
              /*ButtonSettings(
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
                                  cancelScheduledNotifications('Směsný odpad');
                                  cancelScheduledNotifications('Papír');
                                  cancelScheduledNotifications('Bioodpad');
                                  cancelScheduledNotifications('Plast');
                                  setState(
                                    () {
                                      controller.dismiss();
                                      showSnackBar(
                                          context, 'Všechny notifikace zrušeny');
                                      isSwitchedPlastic = false;
                                      isSwitchedMixed = false;
                                      isSwitchedPaper = false;
                                      isSwitchedBio = false;
                                    },
                                  );
                                  setPreferencesAll();
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
                  title: 'Zrušit upozornění',
                  subtitle: 'Zrušíte všechna nastavená upozornění',
                  icon: Icons.notifications_off,
                  color: Colors.redAccent,
                ),*/
            ],
          ),
        ],
      ),
    );
  }
}
