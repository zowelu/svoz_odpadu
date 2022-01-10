import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:svoz_odpadu/components/global_var.dart';
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

Future<void> createScheduledReminderNotification(
    NotificationWeekAndTime notificationScheduled) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: '${Emojis.symbols_red_exclamation_mark} Popelnice ${Emojis.symbols_red_exclamation_mark}',
      body: 'Dnes se vyváží popelnice. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
      bigPicture: 'asset://assets/images/popelnice.jpg',
      notificationLayout: NotificationLayout.BigPicture,
      wakeUpScreen: true,
    ),
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
      preciseAlarm: true,
      allowWhileIdle: true,
    ),
  );
}

Future<void> createScheduledReminderNotificationPlastic(
    NotificationWeekAndTime notificationScheduled,int day,int month,int year) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'Plast',
      title: '${Emojis.symbols_red_exclamation_mark} Popelnice  - Plast a nápojový karton + drobné kovy${Emojis.symbols_red_exclamation_mark}',
      body: 'Dnes se vyváží popelnice - Plast a nápojový karton + drobné kovy. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
      bigPicture: 'asset://assets/images/popelnice.jpg',
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

Future<void> createScheduledReminderNotificationBio(
    NotificationWeekAndTime notificationScheduled,int day,int month,int year) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'Bioodpad',
      title: '${Emojis.symbols_red_exclamation_mark} Popelnice - Bioodpad${Emojis.symbols_red_exclamation_mark}',
      body: 'Dnes se vyváží popelnice - Bioodpad. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
      bigPicture: 'asset://assets/images/popelnice.jpg',
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
      weekday: notificationScheduled.dayOfTheWeek,
      hour: notificationScheduled.timeOfDay.hour,
      minute: notificationScheduled.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      preciseAlarm: true,
      allowWhileIdle: true,
    ),
  );
}

Future<void> createScheduledReminderNotificationPaper(
    NotificationWeekAndTime notificationScheduled,int day,int month,int year) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'Papír',
      title: '${Emojis.symbols_red_exclamation_mark} Popelnice - Papír${Emojis.symbols_red_exclamation_mark}',
      body: 'Dnes se vyváží popelnice - Papír. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
      bigPicture: 'asset://assets/images/popelnice.jpg',
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

Future<void> createScheduledReminderNotificationMixed(
    NotificationWeekAndTime notificationScheduled, int day, int month,int year) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'Směsný odpad',
      title: '${Emojis.symbols_red_exclamation_mark} Popelnice - Směsný odpad ${Emojis.symbols_red_exclamation_mark}',
      body: 'Dnes se vyváží popelnice - Směsný odpad. Nezapomeňte${Emojis.symbols_red_exclamation_mark}',
      bigPicture: 'asset://assets/images/popelnice.jpg',
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