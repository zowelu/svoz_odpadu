import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/notifications.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svoz_odpadu/components/utilities.dart';
import 'package:svoz_odpadu/components/button_settings.dart';
import 'package:svoz_odpadu/components/global_var.dart';

class SettingsPage extends StatefulWidget {
  static const id = '/homePage';

  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
          preferredSize: Size.fromHeight(kDMyAppBarHeight), child: MyAppBar()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: kDBackgroundColorCalendar,
            width: double.infinity,
            height: kDMyAppBarHeight,
            child: const Center(
              child: TextHeader(text: 'Nastavení'),
            ),
          ),
          Flexible(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                /*TextNormal(
                        text: activeSheduledReminder
                            ? 'Máte zapnuté upozorňování.\n$selectedDayGlobal v ${selectedTimeOfDayGlobal.toString().replaceAll('TimeOfDay', '').replaceAll('(', '').replaceAll(')', '')}'
                            : 'Nemáte žádná zapnutá upozornění'),*/
                ButtonSettings(
                  onTap: () async {
                    NotificationWeekAndTime? pickedShedule =
                        await pickSchedule(context);

                    if (pickedShedule != null) {
                      createScheduledReminderNotification(pickedShedule);
                    }
                    setState(() {
                      activeSheduledReminder = true;
                    });
                  },
                  title: 'Nastavit upozornění',
                  subtitle:
                      'Nastavíte upozornění na zvolený den a čas každý týden',
                  icon: Icons.notifications,
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonSettings(
                  onTap: () {
                    cancelScheduledNotifications;
                    setState(() {
                      activeSheduledReminder = false;
                      selectedDayGlobal = '';
                      selectedTimeOfDayGlobal = const TimeOfDay(hour: 0, minute: 0);
                    });
                  },
                  title: 'Zrušit upozornění',
                  subtitle: 'Zrušíte všechna nastavená upozornění',
                  icon: Icons.notifications_off,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(mainAxisAlignment: MainAxisAlignment.end,
              children: [
            activeSheduledReminder
                ? Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0),),
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
          ),
        ],
      ),
    );
  }
}
