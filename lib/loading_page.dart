// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:svoz_odpadu/components/shared_preferences_global.dart';
import 'package:svoz_odpadu/components/text_header.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:svoz_odpadu/components/calendar_item.dart';



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
        sharedPreferencesGlobal.initializePreference().whenComplete(() {
          setState(() {});
          getPreference();
          getData();
        });
      } else {
        animation.forward();
      }
    });
    animation.repeat();
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

  void getData() async {
    //map pro získání index a zároveň odkazy na calendarID
    Map<String, String> calendarID = {
      'směsný': '13r56ftkqvl368a14fimn1ifc4@group.calendar.google.com',
      'plast': 'go5dkg6cnflo277vhc6cbemt3k@group.calendar.google.com',
      'papír': 'p7g0np51igvv0bko1bf4nmtmf0@group.calendar.google.com',
      'bioodpad': 'bnjcsj8qmn2guo40789odlvrvo@group.calendar.google.com'
    };
    //cyklus o počtu opakování dle počtu kalendářů
    for (int i = 0; i < calendarID.length; i++) {
      String calendarIDindex = calendarID.values.elementAt(i);
      int index = i;
      print('index $index, calendarIDindex $calendarIDindex');
      final url = Uri.parse(
          'https://www.googleapis.com/calendar/v3/calendars/$calendarIDindex/events?key=AIzaSyCCpkDJ_trt3VZpmaSqQRdLTPJBAVmg5vY');
      http.Response response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<CalendarItem> calendarItems = [];
        String responseData = response.body;
        List<dynamic> itemsResponseData = jsonDecode(responseData)['items'];
        for (int i = 0; i < itemsResponseData.length; i++) {
          if (itemsResponseData[i]['status'] != 'cancelled') {
            CalendarItem calendarItem = CalendarItem(
                status: itemsResponseData[i]['status'],
                summary: itemsResponseData[i]['summary'],
                start: itemsResponseData[i]['start']['date'],
                end: itemsResponseData[i]['end']['date'],
                recurrence: itemsResponseData[i]['recurrence'] != null
                    ? itemsResponseData[i]['recurrence'][0]
                    : 'not');
            print(calendarItem);
            calendarItems.add(calendarItem);
          }
        }
      } else
        print(response.statusCode);
    }
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
