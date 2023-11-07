import 'package:url_launcher/url_launcher.dart';

Future<void> myLaunchUrl(url) async {
  final Uri urlParse = Uri.parse(url);
  await launchUrl(mode: LaunchMode.externalNonBrowserApplication, urlParse);
}
