import 'package:flutter/material.dart';
import '../util/firebase_methods/firestore_methods.dart';
import '../util/helper/navigation.dart';

import '../util/helper/awesome_dialog.dart';

class ContactUsController with ChangeNotifier {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController whatsAppNumber = TextEditingController();
  TextEditingController reson = TextEditingController();
  TextEditingController message = TextEditingController();

  void sendContact(BuildContext context) {
    if (emailAddress.text.isNotEmpty &&
        userName.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty &&
        whatsAppNumber.text.isNotEmpty &&
        reson.text.isNotEmpty &&
        message.text.isNotEmpty) {
      FirestoreMethods.addContactUs(context,
          email: emailAddress.text,
          message: message.text,
          userName: userName.text,
          phoneNumber: phoneNumber.text,
          reson: reson.text,
          whatsappNumber: whatsAppNumber.text);
    } else {
      myAwesomeDialog(context, onTap: () {
        context.goBack();
      }, title: 'تحذير', content: 'من فضلك ادخل جميع المدخلات المطلوبة');
    }
  }
}
