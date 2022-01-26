import 'package:flutter/material.dart';
import 'package:svoz_odpadu/variables/constants.dart';


class DividerMenu extends StatelessWidget {
  const DividerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(color: kDBackgroundColor, height: 2, thickness: 2);
  }
}