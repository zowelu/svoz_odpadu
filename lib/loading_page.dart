// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/shared_preferences_global.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';
import 'package:svoz_odpadu/components/calendar_data.dart';



class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  static const id = '/loadingPage';

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  SharedPreferencesGlobal sharedPreferencesGlobal = SharedPreferencesGlobal();

  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  bool isLoading = true;
  final CalendarData calendarData = CalendarData();

  //map pro získání index a zároveň odkazy na calendarID
  Map<String, String> calendarID = {
    'směsný': '13r56ftkqvl368a14fimn1ifc4@group.calendar.google.com',
    'plast': 'go5dkg6cnflo277vhc6cbemt3k@group.calendar.google.com',
    'papír': 'p7g0np51igvv0bko1bf4nmtmf0@group.calendar.google.com',
    'bioodpad': 'bnjcsj8qmn2guo40789odlvrvo@group.calendar.google.com'
  };

  @override
  void initState() {
    super.initState();
    currentPage = LoadingPage.id;
    animation = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(max: 1.0, reverse: false);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

    animation.addListener(() {
      if (animation.isCompleted) {
        animation.stop();
        isLoading = false;
        sortOutData();
      } else {
        animation.forward();
      }
    });
    animation.repeat();
  }

  void sortOutData()async {
    sharedPreferencesGlobal.initializePreference().whenComplete(() {
      getPreference();
    });
    await calendarData.getCalendarData(calendarID);
    calendarData.classifyCalendarData();
  }

  void getPreference() async {
    await sharedPreferencesGlobal.getPreferencesValueCity();
    print('sharedPreferenceLoading Page, $valueCityPicked');
    if (!isLoading) {
      if ((valueCityPicked == 'Vybrat obec/město') ||
          (valueCityPicked == null)) {
        print('přesměrováno na CityPicker, $valueCityPicked');
        /*Future.delayed(const Duration(seconds: 4),
            () => Navigator.popAndPushNamed(context, CityPickerPage.id));*/
      } else {
        print('přesměrováno na homePage, $valueCityPicked');
        /*Future.delayed(const Duration(seconds: 4),
            () => Navigator.pushReplacementNamed(context, HomePage.id));*/
      }
    }
  }

  @override
  void dispose() {
    currentPage = LoadingPage.id;
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: FadeTransition(
              opacity: _fadeInFadeOut,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: kDMarginLarger,
                  ),
                  Image.asset('assets/images/app_icon.png'),
                  const SizedBox(
                    height: kDMarginLarger,
                  ),
                  const TextHeader(
                    text: 'Svoz odpadu',
                    fontSize: 30,
                  ),
                  const SizedBox(
                    height: kDMarginLarger * 3,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: const TextNormal(text: 'Aplikaci vytvořili:'),
                  ),
                  const SizedBox(
                    width: kDMarginLarger,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 100 * 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Image.asset(
                                'assets/images/webstrong-logo.png',
                                height: 50,
                              )),
                        ),
                        const SizedBox(
                          width: kDMarginLarger,
                          child: Center(child: TextNormal(text: 'a')),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Image.asset(
                                  'assets/images/zowelu_logo.png',
                                  height: 50)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(kDMargin),
              child: isLoading
                  ? Column(
                      children: const [
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        SizedBox(height: kDMarginLarger),
                        TextNormal(
                          text: 'Načítám...',
                        )
                      ],
                    )
                  : const TextNormal(text: 'Načteno'),
            ),
          ),
        ],
      ),
    );
  }
}
