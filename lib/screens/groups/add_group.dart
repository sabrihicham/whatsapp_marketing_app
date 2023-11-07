import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../controller/langs.dart';
import '../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import '../../controller/sms_controller.dart';
import '../login/widgets/login_button.dart';
import '../login/widgets/my_text_field.dart';
import '../../util/helper/navigation.dart';

import '../login/widgets/login_head_text.dart';

class AddGroupsScreen extends StatefulWidget {
  const AddGroupsScreen({super.key});

  @override
  State<AddGroupsScreen> createState() => _AddGroupsScreenState();
}

class _AddGroupsScreenState extends State<AddGroupsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<SMSController>().getContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    SMSController controller = context.watch<SMSController>();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('إضافة قائمة'),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 25,
            right: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextField(
                hintText: 'اسم المجموعة',
                icon: Icons.group_rounded,
                controller: context.watch<SMSController>().groupNameController,
              ),
              const LoginHeadText(title: 'إختار جهات الاتصال', hint: ''),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.myContacts.length,
                  // shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Contact contact = controller.myContacts.elementAt(index);
                    bool isSelected =
                        controller.selectedContacts.contains(contact);

                    return ListTile(
                      title: Text(contact.displayName ?? ''),
                      subtitle: Text(contact.phones!.isNotEmpty
                          ? contact.phones!.first.value!
                          : ''),
                      trailing: Checkbox(
                        value: isSelected,
                        onChanged: (_) => context
                            .read<SMSController>()
                            .toggleContactSelection(contact),
                      ),
                    );
                  },
                ),
              ),
              LoginButton(
                text: 'إنشاء',
                onPressed: () => context
                    .read<SMSController>()
                    .uploadContacts(context, firebaseAuth.currentUser!.email!),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
