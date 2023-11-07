import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_marketing/util/helper/awesome_dialog.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';

import '../screens/packages_screen/screens/payment_request.dart';

class DisCountController with ChangeNotifier {
  TextEditingController discountCode = TextEditingController();

  String priceAfterDiscount(String priceBeforeDiscount, int discountValue) {
    late int myPriceBeforeDiscount;
    try {
      myPriceBeforeDiscount = int.parse(priceBeforeDiscount);
      return (myPriceBeforeDiscount - discountValue).toString();
    } catch (e) {
      return 0.toString();
    }
  }

  doDiscound(
    BuildContext context, {
    required String packageName,
    required String packagePrice,
  }) async {
    if (discountCode.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('discountCodes')
            .where('code', isEqualTo: discountCode.text)
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            int discountValue = int.parse(value.docs[0]['discount']);
            context.goTo(PaymentRequestScreen(
              packageName: packageName,
              packagePrice: packagePrice,
              discountValue: discountValue,
            ));
          } else {
            myAwesomeDialog(
              context,
              onTap: () {
                context.goBack();
              },
              title: 'خطأ',
              content: 'من فصلك ادخل كود الخصم الصحيح',
            );
          }
        });
      } catch (e) {
        //
      }
    } else {
      myAwesomeDialog(context, onTap: () {
        context.goBack();
      }, title: 'خطأ', content: 'من فصلك ادخل كود الخصم');
    }
  }
}
