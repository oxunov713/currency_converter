import 'package:url_launcher/url_launcher.dart';

class UrlService {
  Future<void> flaunchURl(Uri uri, bool inApp) async {
    try {
      if (await canLaunchUrl(uri)) {
        if (inApp) {
          await launchUrl(uri, mode: LaunchMode.inAppWebView);
        } else {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } else {
        print("Cannot launch URL: $uri");
      }
    } catch (e) {
      print("Error launching URL: ${e.toString()}");
    }
  }
}
