import 'package:flutter/material.dart';
import 'package:svoz_odpadu/variables/constants.dart';

class FABHome extends StatefulWidget {
  const FABHome({Key? key}) : super(key: key);

  @override
  _FABHomeState createState() => _FABHomeState();
}

class _FABHomeState extends State<FABHome> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor =
        ColorTween(begin: kDBackgroundColor, end: kDBackgroundColor)
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.00, 1.00, curve: _curve),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: kDBackgroundColorCalendar,
      tooltip: 'Toggle',
      onPressed: animate,
      child:
          AnimatedIcon(icon: AnimatedIcons.list_view,color: kDBackgroundColor, progress: _animateIcon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}
