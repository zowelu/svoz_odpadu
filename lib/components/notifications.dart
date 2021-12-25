import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:svoz_odpadu/utilities.dart';

Future<void> createBasicNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
          '${Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark} ',
      body:
          'Nezapomeňte vyvést popelnice ${Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark}',
      bigPicture: 'asset://assets/images/notification_map.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

Future<void> createScheduledReminderNotification(
    NotificationWeekAndTime notificationScheduled) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'scheduled_channel',
        title: '${Emojis.symbols_warning} Popenice!!!',
        body: 'Dnes se vyváží popelnice. Nezapomeňte!!!',
        notificationLayout: NotificationLayout.Default),
    actionButtons: [
      NotificationActionButton(key: 'MARK_DONE', label: 'Hotovo')
    ],
    schedule: NotificationCalendar(
      repeats: true,
      weekday: notificationScheduled.dayOfTheWeek,
      hour: notificationScheduled.timeOfDay.hour,
      minute: notificationScheduled.timeOfDay.minute,
      second: 0,
      millisecond: 0,
    ),
  );
}
