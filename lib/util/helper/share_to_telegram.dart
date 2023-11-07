// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'awesome_dialog.dart';
import 'navigation.dart';

void sharePhotoToTelegram(BuildContext context,
    {String? imagePath, required String caption}) async {
  String? telegramUrl;
  Uri? finalLink;
  String encodedCaption = Uri.encodeComponent(caption);
  if (imagePath != null) {
    telegramUrl =
        'https://t.me/share/photo?url=$imagePath&caption=$encodedCaption';
    finalLink = Uri.parse(telegramUrl);
  } else {
    telegramUrl = 'https://t.me/share?url=$encodedCaption';

    finalLink = Uri.parse(telegramUrl);
  }

  if (await canLaunchUrl(finalLink)) {
    await launchUrl(finalLink);
  } else {
    myAwesomeDialog(context, onTap: () {
      context.goBack();
    }, title: 'خطأ', content: 'الرجاء التاكد من ان تطبيق التيليجرام مثبت لديك');
  }
}
