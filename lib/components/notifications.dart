import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:svoz_odpadu/components/utilities.dart';

Future<void> createBasicNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
          '${Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark} ',
      body:
          'Nezapomeňte vyvést popelnice ${Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark}',
      bigPicture: 'asset://assets/images/popelnice.jpg',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

///vytvoří notifikaci dle parametrů
Future<void> createScheduledReminderNotification(
    NotificationWeekAndTime notificationScheduled,
    String channelKey,
    String title,
    String body,
    String bigPicture,
    int day,
    int month,
    int year) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      //channelKey: 'scheduled_channel',
      channelKey: channelKey,
      //title: '${Emojis.symbols_red_exclamation_mark} Popelnice ${Emojis.symbols_red_exclamation_mark}',
      title: title,
      //body: 'Dnes se vyváží popelnice. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
      body: body,
      //bigPicture: 'asset://assets/images/popelnice.jpg',
      bigPicture: bigPicture,
      notificationLayout: NotificationLayout.BigPicture,
      wakeUpScreen: true,
    ),
    actionButtons: [
      NotificationActionButton(key: 'MARK_DONE', label: 'Hotovo')
    ],
    schedule: NotificationCalendar(
      repeats: false,
      day: day,
      month: month,
      year: year,
      hour: notificationScheduled.timeOfDay.hour,
      minute: notificationScheduled.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      preciseAlarm: true,
      allowWhileIdle: true,
    ),
  );
}

///zruší všechny plánované notifikace
Future<void> cancelScheduledNotificationsAll() async {
  await AwesomeNotifications().cancelAllSchedules();
}

///zruší plánované notifikace dle klíče notifikačního kanálu
Future<void> cancelScheduledNotifications(channelKey) async {
  await AwesomeNotifications().cancelSchedulesByChannelKey(channelKey);
}

///zruší všechny basic notifikace
Future<void> cancelNotifications() async {
  await AwesomeNotifications().cancelAll();
}