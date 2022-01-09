import 'package:flutter/material.dart';
import 'package:svoz_odpadu/constants/constants.dart';
import 'package:svoz_odpadu/components/open_url_in_browser.dart';

class AboutAppDialog extends StatefulWidget {
  const AboutAppDialog({Key? key}) : super(key: key);

  @override
  _AboutAppDialogState createState() => _AboutAppDialogState();
}

class _AboutAppDialogState extends State<AboutAppDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDPadding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
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
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Kalendář svozu odpadu\nv Dolních Kounicích',
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
                height: kDMargin,
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
                  GestureDetector(
                    onTap: () async {
                      //po stisknutí otevře stránku v externím prohlížeči
                      OpenUrlInBrowser().openUrl('https://webstrong.cz/');
                    },
                    child: Image.asset('assets/images/webstrong-logo.png',
                        height: 25),
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
                  OpenUrlInBrowser().openUrl('https://webstrong.cz/');
                },
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
                        OpenUrlInBrowser().openUrl('https://www.zowelu.cz/');
                      },
                      child: Image.asset('assets/images/zowelu_logo.png',
                          height: 30),
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
                  OpenUrlInBrowser().openUrl('https://www.zowelu.cz/');
                },
              ),
              const SizedBox(
                height: 22,
              ),
              const Text(
                'Text, fotografie jsou použity\nz dostupných pramenů\na zdrojů z webových stránek www.DolniKounice.cz',
                style: TextStyle(
                    fontSize: kDFontSizeText,
                    fontFamily: kDFontFamilyParagraph),
                textAlign: TextAlign.center,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Zavřít',
                      style: TextStyle(
                        fontSize: kDFontSizeText,
                        fontFamily: kDFontFamilyParagraph,
                        color: kDBackgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
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
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              child: Image.asset('assets/images/app_icon.png'),
            ),
          ),
        ),
      ],
    );
  }
}
