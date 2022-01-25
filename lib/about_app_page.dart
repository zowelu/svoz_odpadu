import 'package:flutter/material.dart';
import 'package:svoz_odpadu/variables/constants.dart';
import 'package:svoz_odpadu/variables/global_var.dart';
import 'package:svoz_odpadu/components/open_url_in_browser.dart';

import 'components/my_appbar.dart';
import 'components/text_header.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({Key? key}) : super(key: key);
  static const id = '/aboutAppPage';
  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  void initState() {
    super.initState();
    currentPage = AboutAppPage.id;
  }

  @override
  void dispose() {
    currentPage = AboutAppPage.id;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDBackgroundColor,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kDMyAppBarHeight), child: MyAppBar()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: kDBackgroundColorCalendar,
              width: double.infinity,
              height: kDMyAppBarHeight,
              child: const Center(
                child: TextHeader(
                  text: 'O aplikaci',
                  color: kDBackgroundColor,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: kDBackgroundColor,
              ),
              padding: const EdgeInsets.all(kDMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            left: kDPadding,
                            top: 70.0 + kDPadding,
                            right: kDPadding,
                            bottom: kDPadding),
                        margin: const EdgeInsets.only(top: kDMarginLarger),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(kDPadding),
                            boxShadow: const [
                              BoxShadow(
                                  color: kDBoxShadowColor,
                                  offset: Offset(0, 10),
                                  blurRadius: 10),
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              'Svoz odpadu',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: kDFontFamilyHeader),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'verze: $versionApp',
                              style: TextStyle(
                                  fontSize: kDFontSizeText,
                                  fontFamily: kDFontFamilyParagraph),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: kDMarginLarger,
                            ),
                            const Text(
                              'Tato aplikace je poskytnuta zdarma Městu Dolní Kounice a jeho občanům.',
                              style: TextStyle(
                                  fontSize: kDFontSizeText,
                                  fontFamily: kDFontFamilyParagraph),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: kDMarginLarger,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Aplikaci vytvořil',
                                  style: TextStyle(
                                      fontSize: kDFontSizeText,
                                      fontFamily: kDFontFamilyParagraph),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: kDMargin,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 10.0,
                                    top: 0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      //po stisknutí otevře stránku v externím prohlížeči
                                      OpenUrlInBrowser()
                                          .openUrl('https://www.zowelu.cz/');
                                    },
                                    child: Image.asset(
                                        'assets/images/zowelu_logo.png',
                                        height: 35),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              child: const Text(
                                'www.zowelu.cz',
                                style: TextStyle(
                                    fontSize: kDFontSizeText,
                                    fontFamily: kDFontFamilyParagraph,
                                    decoration: TextDecoration.underline),
                                textAlign: TextAlign.center,
                              ),
                              onTap: () async {
                                //po stisknutí otevře stránku v externím prohlížeči
                                OpenUrlInBrowser()
                                    .openUrl('https://www.zowelu.cz/');
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  've spolupráci s ',
                                  style: TextStyle(
                                      fontSize: kDFontSizeText,
                                      fontFamily: kDFontFamilyParagraph),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: kDMargin,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 10.0,
                                    top: 0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      //po stisknutí otevře stránku v externím prohlížeči
                                      OpenUrlInBrowser()
                                          .openUrl('https://webstrong.cz/');
                                    },
                                    child: Image.asset(
                                        'assets/images/webstrong-logo.png',
                                        height: 25),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              child: const Text(
                                'www.webstrong.cz',
                                style: TextStyle(
                                    fontSize: kDFontSizeText,
                                    fontFamily: kDFontFamilyParagraph,
                                    decoration: TextDecoration.underline),
                                textAlign: TextAlign.center,
                              ),
                              onTap: () async {
                                //po stisknutí otevře stránku v externím prohlížeči
                                OpenUrlInBrowser()
                                    .openUrl('https://webstrong.cz/');
                              },
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 100,
                        right: 100,
                        child: CircleAvatar(
                          backgroundColor: kDBackgroundColor,
                          radius: 50.0,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            child: Image.asset('assets/images/app_icon.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
