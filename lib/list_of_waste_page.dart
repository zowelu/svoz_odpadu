import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/text_header.dart';

class ListOfWastePage extends StatefulWidget {
  const ListOfWastePage({Key? key}) : super(key: key);
  static const id = '/listOfWastePage';

  @override
  _ListOfWastePageState createState() => _ListOfWastePageState();
}

class _ListOfWastePageState extends State<ListOfWastePage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: TextHeader(text: 'Ahoj',),);
  }
}
