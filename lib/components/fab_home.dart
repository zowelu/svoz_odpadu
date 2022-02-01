import 'package:flutter/material.dart';
import 'package:svoz_odpadu/list_of_waste_page.dart';
import 'package:svoz_odpadu/variables/constants.dart';

class FABHome extends StatefulWidget {
  const FABHome({
    Key? key,
  }) : super(key: key);
//final _FABHomeState fabHomeState = new _FABHomeState();

  @override
  _FABHomeState createState() => _FABHomeState();
}

class _FABHomeState extends State<FABHome> with SingleTickerProviderStateMixin {
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: kDBackgroundColorCalendar,
      tooltip: 'Toggle',
      onPressed: () {
        Navigator.pushNamed(context, ListOfWastePage.id);
      },
      child: const Icon(
        Icons.view_list_rounded,
        color: kDBackgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}
