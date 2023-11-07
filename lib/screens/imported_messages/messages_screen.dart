import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../controller/langs.dart';
import '../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import '../../util/helper/navigation.dart';

import '../../controller/notifications_controller.dart';
import 'imported_messages.dart';

class MessagesScreen extends StatelessWidget {
  static const String routeName = 'messagesScreen';

  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            langsController.langs[langsController.lang ?? 'ar']!['imported']!,
          ),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: FutureBuilder(
          future: context
              .read<NotificationsController>()
              .getMessages(firebaseAuth.currentUser!.email!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "لقد حدث خطأ غير متوقع الرجاء المحاولة مرة أخري",
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return MessagesItem(
                      title: snapshot.data!.docs[index]['massege'],
                      type: snapshot.data!.docs[index]['type'],
                      data: {
                        'name': snapshot.data!.docs[index]['sender'],
                        'title': snapshot.data!.docs[index]['massege'],
                        'email': snapshot.data!.docs[index]['toEmail'],
                      },
                    );
                  },
                );
              } else {
                return const Text('ليس لديك اي رسائل');
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
