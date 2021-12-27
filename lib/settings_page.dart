import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/notifications.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svoz_odpadu/utilities.dart';
import 'package:svoz_odpadu/components/button_settings.dart';

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
          preferredSize: Size.fromHeight(kDMyAppBarHeight), child: MyAppBar()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: kDBackgroundColorCalendar,
            width: double.infinity,
            child: const Center(
              child: TextHeader(text: 'Nastavení'),
            ),
          ),
          Column(
            children: [
              ButtonSettings(
                onTap: () async {
                  NotificationWeekAndTime? pickedShedule =
                      await pickSchedule(context);

                  if (pickedShedule != null) {
                    createScheduledReminderNotification(pickedShedule);
                  }
                },
                title: 'Nastavit upozornění',
                subtitle:
                    'Nastavíte upozornění na zvolený den a čas každý týden',
                icon: Icons.notifications,
              ),
              ButtonSettings(
                onTap: cancelScheduledNotifications,
                title: 'Zrušit upozornění',
                subtitle: 'Zrušíte všechna nastavená upozornění',
                icon: Icons.notifications_off,
              ),
            ],
          )
        ],
      ),
    );
  }
}
