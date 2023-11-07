import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_marketing/screens/groups/widgets/group_item.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';

import '../../../controller/groups_controller.dart';
import '../screens/send_messages.dart';

class FromGruops extends StatelessWidget {
  const FromGruops({
    super.key,
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context
          .read<GroupsController>()
          .getGroups(firebaseAuth.currentUser!.email!),
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
              padding: const EdgeInsets.only(
                top: 10,
                // left: 15,
                // right: 15,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (context.watch<GroupsController>().numbers.isNotEmpty) {
                  return GroupItem(
                    name: snapshot.data!.docs[index]['groupName'],
                    numberOfUsers: context
                        .watch<GroupsController>()
                        .numbers
                        .where((element) =>
                            element['group'] == snapshot.data!.docs[index].id)
                        .length
                        .toString(),
                    onTap: () => context.goTo(
                      SendMessagesScreen(
                        numbers: context
                            .read<GroupsController>()
                            .numbers
                            .where((element) =>
                                element['group'] ==
                                snapshot.data!.docs[index].id)
                            .toList(),
                      ),
                    ),
                  );
                } else {
                  return const Text('you don\'t have data ');
                }
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
    );
  }
}
