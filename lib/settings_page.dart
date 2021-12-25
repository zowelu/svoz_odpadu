import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/notifications.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/components/my_appbar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svoz_odpadu/utilities.dart';

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
      body: Container(
        padding: const EdgeInsets.only(top: kDMarginLarger),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: createBasicNotification,
              icon: const Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () async {NotificationWeekAndTime? pickedShedule = await pickSchedule(context);

              if(pickedShedule != null){
                createScheduledReminderNotification(pickedShedule);
              }},
              icon: const Icon(Icons.notifications_active),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_off),
            ),
          ],
        ),
      ),
    );
  }
}
