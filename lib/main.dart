import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:svoz_odpadu/screens/home_page.dart';
import 'package:svoz_odpadu/services/calendar_service.dart';

void main() async {
  Logger.root.level = Level.ALL;
  GetIt.instance.registerSingleton<CalendarService>(CalendarService());
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
          fontFamily: 'Righteous',
          textTheme: const TextTheme(
            labelMedium: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 16),
          )),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
