import 'package:flutter/material.dart';
import 'package:svoz_odpadu/city_picker_page.dart';
import 'package:svoz_odpadu/components/button_settings.dart';
import 'package:svoz_odpadu/components/shared_preferences_global.dart';
import 'package:svoz_odpadu/components/text_normal.dart';
import 'package:svoz_odpadu/home_page.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';

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

  @override
  void initState() {
    super.initState();
    currentPage = LoadingPage.id;
    animation = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(max: 1.0, reverse: false);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

    animation.addListener((){
      if(animation.isCompleted){
        animation.reverse();
      }else{
        animation.forward();
      }
    });
    animation.repeat();

    sharedPreferencesGlobal.initializePreference().whenComplete(() {
      setState(() {

      });
      getPreference();

    });
  }

  void getPreference() async {
    await sharedPreferencesGlobal.getPreferencesValueCity();
    print('sharedPreferenceLoading Page, $valueCityPicked');
    if ((valueCityPicked == 'Vybrat obec/město') ||
        (valueCityPicked == null)) {
      print('přesměrováno na CityPicker, $valueCityPicked');
      Future.delayed(const Duration(seconds: 4),
            () => Navigator.popAndPushNamed(context, CityPickerPage.id));
    }
    else  {
      print('přesměrováno na homePage, $valueCityPicked');
      Future.delayed(const Duration(seconds: 4),
            () => Navigator.pushReplacementNamed(context, HomePage.id));
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
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonSettings(
              onTap: () {
                Navigator.pushNamed(context, HomePage.id);
              },
              title: 'Přejít na HomePage',
              subtitle: 'přejít',
              icon: Icons.home),
          const SizedBox(height: 100),
          FadeTransition(
            opacity: _fadeInFadeOut,
            child: Column(
              children: [
                // ignore: avoid_unnecessary_containers
                Container(child: const TextNormal(text: 'Aplikaci vytvořili:')),
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
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
