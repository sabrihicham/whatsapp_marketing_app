import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../controller/langs.dart';
import '../../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import '../../../controller/sms_controller.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';

import '../widgets/from_groups.dart';
import '../widgets/from_sms.dart';
import '../widgets/tab_view_item.dart';

class SMSScreen extends StatefulWidget {
  static const String routeName = 'SMSScreen';

  const SMSScreen({super.key});

  @override
  State<SMSScreen> createState() => _SMSScreenState();
}

class _SMSScreenState extends State<SMSScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<SMSController>().setSelectedContacts();
      context.read<SMSController>().setContactsEmpty();
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        floatingActionButton: context.watch<SMSController>().selectedItem == 0
            ? FloatingActionButton(
                tooltip: langsController
                    .langs[langsController.lang ?? 'ar']!['send']!,
                heroTag: 'send',
                onPressed: () {
                  context.read<SMSController>().mySendSMS(context);
                },
                child: Transform.rotate(
                  angle: (22 / 7),
                  child: const Icon(Icons.send_rounded),
                ),
              )
            : null,
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              Text(langsController
                  .langs[langsController.lang ?? 'ar']!['lanch_ad']!),
              const SizedBox(width: 10),
              Image.asset(
                'assets/missile.png',
                width: 35,
              ),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Provider.of<SMSController>(context, listen: false).downloadLink =
                  '';
              Provider.of<SMSController>(context, listen: false).isloading =
                  false;
              context.goBack();
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: MyTapViewItem(
                    text: langsController
                        .langs[langsController.lang ?? 'ar']!['dalil_phone']!,
                    id: 0,
                  ),
                ),
                // MyTapViewItem(
                //   text: 'القوائم',
                //   id: 1,
                // ),
              ],
            ),
            Expanded(
              child: context.watch<SMSController>().selectedItem == 0
                  ? const SMSFromPhone()
                  : FromGruops(
                      firebaseAuth: firebaseAuth,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
