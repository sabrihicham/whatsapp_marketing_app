import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../controller/langs.dart';
import '../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import '../../util/helper/navigation.dart';

import '../../controller/notifications_controller.dart';
import '../../util/helper/awesome_dialog.dart';
import 'messages_details.dart';

class ImportedMessagesScreen extends StatelessWidget {
  static const String routeName = 'imported_messagesScreen';

  const ImportedMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            langsController.langs[langsController.lang ?? 'ar']!['noti']!,
          ),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: FutureBuilder(
          future: context.read<NotificationsController>().getNotifications(),
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
                        'id': snapshot.data!.docs[index].id,
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

class MessagesItem extends StatefulWidget {
  final String title, type;
  final Map<String, String> data;
  const MessagesItem({
    super.key,
    required this.title,
    required this.type,
    required this.data,
  });

  @override
  State<MessagesItem> createState() => _MessagesItemState();
}

class _MessagesItemState extends State<MessagesItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.goTo(MessagesDetialsScreen(data: widget.data));
      },
      trailing: IconButton(
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection('notifications')
              .doc(widget.data['id'])
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
        icon: const Icon(
          Icons.delete_rounded,
          color: Colors.redAccent,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 17,
      ),
      title: Text(
        widget.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFFAAAAAA)),
      ),
      leading: CircleAvatar(
        backgroundColor: const Color(0xffD9D9D9),
        child: Image.asset(
          'assets/notificaions.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
