import 'package:url_launcher/url_launcher.dart';

//funkce otevírající stránku v externím prohlížeči
class OpenUrlInBrowser {
  //String _launchURL ='https://www.dolnikounice.cz/klaster-rosa-coeli/d-78777/p1=4774';

  Future<void> _launchInBrowser(String url) async {
    var urllaunchable =
    await canLaunch(url); //canLaunch is from url_launcher package
    if (urllaunchable) {
      await launch(
          url, forceSafariVC: false, forceWebView: false, headers: <String, String>{'header_key': 'header_value'}); //launch is from url_launcher package to launch URL
    } else {
      // ignore: avoid_print
      print("URL can't be launched.");
    }
  }

  void openUrl(String launchURL) {
    _launchInBrowser(launchURL);
  }
}
