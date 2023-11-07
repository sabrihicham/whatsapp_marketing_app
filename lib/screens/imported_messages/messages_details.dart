import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/langs.dart';
import '../../util/helper/dirction.dart';
import '../../util/helper/navigation.dart';

import '../../util/helper/awesome_dialog.dart';
import '../contact_us/contact_us.dart';
import 'widgets/my_text_rich.dart';

class MessagesDetialsScreen extends StatelessWidget {
  final Map<String, String> data;
  const MessagesDetialsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('رسالة من " ${data['name']!} "'),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 10,
            left: 25,
            right: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              MyTextRich(keyT: 'الاسم :   ', value: data['name']!),
              MyTextRich(keyT: 'البريد الالكتروني :   ', value: data['email']!),
              MyTextRich(keyT: 'تفاصيل الرسالة :   ', value: data['title']!),
              ElevatedButton(
                onPressed: () => context.goToNamed(ContactUsScreen.routeName),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xffF97C09),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        9,
                      ),
                    ),
                  ),
                ),
                child: const Text('ارسال رد'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('notifications')
                      .doc(data['id'])
                      .delete()
                      .then(
                        (value) => myAwesomeDialog(
                          context,
                          title: 'نجح',
                          content: 'تم الحذف بنجاح',
                          onTap: () {
                            context.goBack();
                            context.goBack();
                          },
                        ),
                      );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xffF97C09),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        9,
                      ),
                    ),
                  ),
                ),
                child: const Text('حذف'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
