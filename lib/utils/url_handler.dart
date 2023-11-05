import 'package:url_launcher/url_launcher.dart';

abstract class UrlHandler {
  Future<void> openUrl(String url);
}

class UrlLauncher extends UrlHandler {
  @override
  Future<void> openUrl(String url) async {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}
