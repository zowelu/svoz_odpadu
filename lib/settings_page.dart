// ignore_for_file: unnecessary_this, avoid_print
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/components/list_tile_of_waste_notification.dart';
import 'package:svoz_odpadu/components/notifications.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svoz_odpadu/components/utilities.dart';
import 'package:svoz_odpadu/components/button_settings.dart';
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
  SharedPreferences? preferences;

  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
  }

  ///načte všechny uložené preference
  Future<void> getPreferencesAll() async {
    await getPreferencesPlastic();
    print('get getPreferencesPlastic');
    await getPreferencesBio();
    print('get getPreferencesBio');
    await getPreferencesPaper();
    print('get getPreferencesPaper');
    await getPreferencesMixed();
    print('get getPreferencesMixed');
  }

  /// uložím všechny preference
  Future<void> setPreferencesAll() async {
    await setPreferencesPlastic();
    print('set setPreferencesPlastic');
    await setPreferencesBio();
    print('set setPreferencesBio');
    await setPreferencesPaper();
    print('set setPreferencesPaper');
    await setPreferencesMixed();
    print('set setPreferencesMixed');
  }

  ///get preferences from stored data for Plastic
  Future<void> getPreferencesPlastic() async {
    setState(() {
      isSwitchedPlastic =
          this.preferences!.getBool('isSwitchedPlastic') ?? false;
    });
    String timeStamp =
        this.preferences?.getString('plasticReminderTime') ?? '00:00';
    plasticReminderTime = TimeOfDay(
        hour: (int.parse(timeStamp.split(":")[0])),
        minute: (int.parse(timeStamp.split(":")[1])));
    plasticSelectedDay =
        this.preferences?.getString('plasticSelectedDay') ?? 'V daný den';
    print(
        'load SharedPreferencesPlastic $isSwitchedPlastic, $plasticReminderTime, $plasticSelectedDay');
  }

  ///get preferences from stored data for Bio
  Future<void> getPreferencesBio() async {
    setState(() {
      isSwitchedBio = this.preferences!.getBool('isSwitchedBio') ?? false;
    });
    String timeStamp =
        this.preferences?.getString('bioReminderTime') ?? '00:00';
    bioReminderTime = TimeOfDay(
        hour: int.parse(timeStamp.split(":")[0]),
        minute: int.parse(timeStamp.split(":")[1]));
    bioSelectedDay =
        this.preferences?.getString('bioSelectedDay') ?? 'V daný den';
    print(
        'load SharedPreferencesBio $isSwitchedBio, $bioReminderTime, $bioSelectedDay');
  }

  ///get preferences from stored data for Paper
  Future<void> getPreferencesPaper() async {
    setState(() {
      isSwitchedPaper = this.preferences!.getBool('isSwitchedPaper') ?? false;
    });
    String timeStamp =
        this.preferences?.getString('paperReminderTime') ?? '00:00';
    paperReminderTime = TimeOfDay(
        hour: int.parse(timeStamp.split(":")[0]),
        minute: int.parse(timeStamp.split(":")[1]));
    paperSelectedDay =
        this.preferences?.getString('paperSelectedDay') ?? 'V daný den';
    print(
        'load SharedPreferencesPaper $isSwitchedPaper, $paperReminderTime, $paperSelectedDay');
  }

  ///get preferences from stored data for Mixed
  Future<void> getPreferencesMixed() async {
    setState(() {
      isSwitchedMixed = this.preferences!.getBool('isSwitchedMixed') ?? false;
    });
    String timeStamp =
        this.preferences!.getString('mixedReminderTime') ?? '00:00';
    mixedReminderTime = TimeOfDay(
        hour: int.parse(timeStamp.split(":")[0]),
        minute: int.parse(timeStamp.split(":")[1]));
    mixedSelectedDay =
        this.preferences!.getString('mixedSelectedDay') ?? 'V daný den';
    print(
        'load SharedPreferencesMixed $isSwitchedMixed, $mixedReminderTime, $mixedSelectedDay');
  }

  ///set preferences to stored data for Plastic
  Future<void> setPreferencesPlastic() async {
    this.preferences!.setBool('isSwitchedPlastic', isSwitchedPlastic);
    String timeStampHour = plasticReminderTime!.hour.toString();
    String timeStampMinute = plasticReminderTime!.minute.toString();
    this
        .preferences!
        .setString('plasticReminderTime', '$timeStampHour:$timeStampMinute');
    this.preferences!.setString('plasticSelectedDay', plasticSelectedDay!);
    print(
        'Set SharedPreferencesPlastic $isSwitchedPlastic, $plasticReminderTime, $plasticSelectedDay');
  }

  ///set preferences to stored data for Bio
  Future<void> setPreferencesBio() async {
    this.preferences!.setBool('isSwitchedBio', isSwitchedBio);
    String timeStampHour = bioReminderTime!.hour.toString();
    String timeStampMinute = bioReminderTime!.minute.toString();
    this
        .preferences!
        .setString('bioReminderTime', '$timeStampHour:$timeStampMinute');
    this.preferences!.setString('bioSelectedDay', bioSelectedDay!);
    print(
        'Set SharedPreferencesBio $isSwitchedBio, $bioReminderTime, $bioSelectedDay');
  }

  ///set preferences to stored data for Paper
  Future<void> setPreferencesPaper() async {
    this.preferences!.setBool('isSwitchedPaper', isSwitchedPaper);
    String timeStampHour = paperReminderTime!.hour.toString();
    String timeStampMinute = paperReminderTime!.minute.toString();
    this
        .preferences
        ?.setString('paperReminderTime', '$timeStampHour:$timeStampMinute');
    this.preferences?.setString('paperSelectedDay', paperSelectedDay!);
    print(
        'Set SharedPreferencesPaper $isSwitchedPaper, $paperReminderTime, $paperSelectedDay');
  }

  ///set preferences to stored data for Paper
  Future<void> setPreferencesMixed() async {
    this.preferences!.setBool('isSwitchedMixed', isSwitchedMixed);
    String timeStampHour = mixedReminderTime!.hour.toString();
    String timeStampMinute = mixedReminderTime!.minute.toString();
    this
        .preferences
        ?.setString('mixedReminderTime', '$timeStampHour:$timeStampMinute');
    this.preferences?.setString('mixedSelectedDay', mixedSelectedDay!);
    print(
        'Set SharedPreferencesMixed $isSwitchedMixed, $mixedReminderTime, $mixedSelectedDay');
  }

  @override
  void initState() {
    super.initState();
    currentPage = 'settings';
    initializePreference().whenComplete(() {
      setState(() {
        getPreferencesAll();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('cs');
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kDMyAppBarHeight),
        child: MyAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
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
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(kDMargin),
                        child: const TextHeader(
                          text: 'Nastavení notikací',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(kDMargin),
                        child: const TextNormal(
                          text:
                              'Nastavte si notikace pro jednotlivé druhy odpadů',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
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
                                          'Plast',
                                          '${Emojis.symbols_red_exclamation_mark} Popelnice  - Plast a nápojový karton + drobné kovy${Emojis.symbols_red_exclamation_mark}',
                                          'Dnes se vyváží popelnice - Plast a nápojový karton + drobné kovy. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
                                          'asset://assets/images/popelnice.jpg');
                                      showSnackBar(context,
                                          'Notifikace pro Plast a nápojový karton + Drobné kovy byly vytvořeny');
                                      setState(
                                        () {
                                          isSwitchedPlastic = value;
                                          setPreferencesPlastic();
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
                                                      setPreferencesPlastic();
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
                        ],
                      ),
                      Row(
                        children: [
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
                                          'Bioodpad',
                                          '${Emojis.symbols_red_exclamation_mark} Popelnice - Bioodpad${Emojis.symbols_red_exclamation_mark}',
                                          'Dnes se vyváží popelnice - Bioodpad. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
                                          'asset://assets/images/popelnice.jpg');
                                      showSnackBar(context,
                                          'Notifikace pro Bioodpad byly vytvořeny');
                                      setState(
                                        () {
                                          isSwitchedBio = value;
                                          setPreferencesBio();
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
                                                      controller.dismiss();
                                                      showSnackBar(context,
                                                          'Notifikace zrušeny');
                                                      isSwitchedBio = value;
                                                      setPreferencesBio();
                                                    },
                                                  );
                                                },
                                                child: const Text(
                                                  'Ano, zrušit notifikace',
                                                  style: TextStyle(
                                                      color: kDBackgroundColor,
                                                      fontSize: kDFontSizeText,
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
                            wasteReminderTime: bioReminderTime!,
                            wasteSelectedDay: bioSelectedDay!,
                          ),
                        ],
                      ),
                      Row(
                        children: [
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
                                          setPreferencesPaper();
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
                                                      'Papír');
                                                  setState(
                                                    () {
                                                      controller.dismiss();
                                                      showSnackBar(context,
                                                          'Notifikace zrušeny');
                                                      isSwitchedPaper = value;
                                                      setPreferencesPaper();
                                                    },
                                                  );
                                                },
                                                child: const Text(
                                                  'Ano, zrušit notifikace',
                                                  style: TextStyle(
                                                      color: kDBackgroundColor,
                                                      fontSize: kDFontSizeText,
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
                            wasteReminderTime: paperReminderTime!,
                            wasteSelectedDay: paperSelectedDay!,
                          ),
                        ],
                      ),
                      Row(
                        children: [
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
                                          setPreferencesMixed();
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
                                                      controller.dismiss();
                                                      showSnackBar(context,
                                                          'Notifikace zrušeny');
                                                      isSwitchedMixed = value;
                                                      setPreferencesMixed();
                                                    },
                                                  );
                                                },
                                                child: const Text(
                                                  'Ano, zrušit notifikace',
                                                  style: TextStyle(
                                                      color: kDBackgroundColor,
                                                      fontSize: kDFontSizeText,
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
                            wasteReminderTime: mixedReminderTime!,
                            wasteSelectedDay: mixedSelectedDay!,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ButtonSettings(
                      onTap: () {
                        Navigator.pushNamed(context, CityPickerPage.id);
                      },
                      title: 'CityPickerPage',
                      subtitle: 'Vyberete si své město',
                      icon: Icons.account_tree),
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
                                    cancelScheduledNotifications('Směsný odpad');
                                    cancelScheduledNotifications('Papír');
                                    cancelScheduledNotifications('Bioodpad');
                                    cancelScheduledNotifications('Plast');
                                    setState(
                                      () {
                                        controller.dismiss();
                                        showSnackBar(context,
                                            'Všechny notifikace zrušeny');
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
