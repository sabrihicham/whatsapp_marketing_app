import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../controller/langs.dart';
import '../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import '../contact_methods/screens/send_messages.dart';
import 'widgets/group_item.dart';
import '../../util/helper/navigation.dart';

import '../../controller/groups_controller.dart';
import '../../controller/sms_controller.dart';
import 'add_group.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('القوائم'),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<SMSController>().setSelectedContacts();
                context.goTo(const AddGroupsScreen());
              },
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
        body: FutureBuilder(
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
                    // left: 25,
                    // right: 25,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    if (context.watch<GroupsController>().numbers.isNotEmpty) {
                      return GroupItem(
                        onTap: () {
                          context.goTo(SendMessagesScreen(
                            numbers: context.read<GroupsController>().numbers,
                          ));
                        },
                        name: snapshot.data!.docs[index]['groupName'],
                        numberOfUsers: context
                            .watch<GroupsController>()
                            .numbers
                            .where((element) =>
                                element['group'] ==
                                snapshot.data!.docs[index].id)
                            .length
                            .toString(),
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
        ),
      ),
    );
  }
}
