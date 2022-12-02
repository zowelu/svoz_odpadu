import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svoz_odpadu/screens/home_page.dart';

void main() async {
  initializeDateFormatting().then((_) => runApp(MyApp()));
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
          textTheme: TextTheme(
            labelMedium: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 16),
          )),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
