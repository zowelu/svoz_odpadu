import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:svoz_odpadu/utilities.dart';

Future<void> createBasicNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: '${Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark} '  ,
      body: 'Nezapomeňte vyvést popelnice ${Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark + Emojis.symbols_red_exclamation_mark}',
      bigPicture: 'asset://assets/images/notification_map.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}
