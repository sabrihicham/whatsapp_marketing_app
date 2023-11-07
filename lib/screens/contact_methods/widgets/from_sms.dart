import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/langs.dart';

import '../../../controller/sms_controller.dart';
import '../../login/widgets/my_text_button.dart';
import '../../login/widgets/my_text_field.dart';

class SMSFromPhone extends StatelessWidget {
  const SMSFromPhone({super.key});

  @override
  Widget build(BuildContext context) {
    SMSController controller = context.watch<SMSController>();
    LangsController langsController = context.read<LangsController>();

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
          child: MyTextField(
            hintText: langsController
                .langs[langsController.lang ?? 'ar']!['message']!,
            icon: Icons.message_rounded,
            maxLines: null, // Allows multiline input
            minLines: 4, // Set the minimum number of lines
            inputType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,

            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            controller: context.watch<SMSController>().messageController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
          child: MyTextField(
              hintText:
                  langsController.langs[langsController.lang ?? 'ar']!['link']!,
              icon: Icons.link_rounded,
              controller: context.watch<SMSController>().linkController),
        ),
        MyTextButton(
          text: langsController
              .langs[langsController.lang ?? 'ar']!['add_photo']!,
          onPressed: () => context.read<SMSController>().getImage(context),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Visibility(
            visible: Provider.of<SMSController>(context).isloading,
            child: context.watch<SMSController>().downloadLink != null
                ? Center(
                    child: Text(langsController
                        .langs[langsController.lang ?? 'ar']!['photo']!),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
        if (context.watch<SMSController>().location.lat != null)
          const Text('تم تحديد الموقع')
        else
          MyTextButton(
            text: langsController
                .langs[langsController.lang ?? 'ar']!['add_loc']!,
            onPressed: () => context.read<SMSController>().pickLocation(),
          ),
        ListTile(
          onTap: () => context.read<SMSController>().selectAllContacts(),
          title: Text(
            langsController.langs[langsController.lang ?? 'ar']!['select_all']!,
          ),
          trailing: Checkbox(
            value: context.watch<SMSController>().isAllContactsSelected,
            onChanged: (_) => context.read<SMSController>().selectAllContacts(),
          ),
        ),
        ListView.builder(
          itemCount: controller.myContacts.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Contact contact = controller.myContacts.elementAt(index);
            bool isSelected = controller.selectedContacts.contains(contact);

            return ListTile(
              onTap: () =>
                  context.read<SMSController>().toggleContactSelection(contact),
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
      ],
    );
  }
}
