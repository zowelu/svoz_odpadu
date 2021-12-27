import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/notifications.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svoz_odpadu/utilities.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('cs');
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kDMyAppBarHeight),
            child: MyAppBar()),
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
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextNormal(
                        text: activeSheduledReminder
                            ? 'Máte zapnuté upozorňování'
                            : 'Nemáte žádná zapnutá upozornění'),
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
                    ButtonSettings(
                      onTap: () {
                        cancelScheduledNotifications;
                        setState(() {
                          activeSheduledReminder = false;
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
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: kDBackgroundColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('ahoj'),
                    ],
                  ),
                ),
              )
            ]));
  }
}
