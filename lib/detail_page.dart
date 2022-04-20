import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  static const id = '/detailPage';

  DetailPage({Key? key, this.payload}) : super(key: key);
  String? payload;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(payload!),
    );
  }
}
