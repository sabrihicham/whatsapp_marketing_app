import 'package:flutter/material.dart';
import '../../../controller/langs.dart';
import '../../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import '../../../controller/sms_controller.dart';
import '../../../util/helper/awesome_dialog.dart';
import '../../../util/helper/navigation.dart';

import '../../login/widgets/my_text_button.dart';
import '../../login/widgets/my_text_field.dart';

class SendMessagesScreen extends StatelessWidget {
  const SendMessagesScreen({super.key, required this.numbers});
  final List<Map<dynamic, dynamic>> numbers;
  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'ارسال',
          heroTag: 'send',
          onPressed: () {
            context.read<SMSController>().sendSmsfromGroups(context, numbers);
          },
          child: Transform.rotate(
            angle: (22 / 7),
            child: const Icon(Icons.send_rounded),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('ارسال رسالة الي قائمة'),
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
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: MyTextField(
                hintText: 'اكتب رسالتك هنا',
                icon: Icons.message_rounded,
                maxLines: null,
                minLines: 4,
                inputType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLength: 150,
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                controller: context.watch<SMSController>().messageController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
              child: MyTextField(
                hintText: 'الرابط',
                icon: Icons.link_rounded,
                controller: context.watch<SMSController>().linkController,
              ),
            ),
            MyTextButton(
              text: 'إضافة صورة',
              onPressed: () => context.read<SMSController>().getImage(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Visibility(
                  visible: Provider.of<SMSController>(context).isloading,
                  child: context.watch<SMSController>().downloadLink != null
                      ? const Center(child: Text('تم إضافة الصورة بنجاح'))
                      : const Center(
                          child: CircularProgressIndicator(),
                        )),
            ),
            MyTextButton(
              text: 'أضافة موقع',
              onPressed: () => myAwesomeDialog(context, onTap: () {
                context.goBack();
              }, title: 'ملحوظة', content: 'سيتم العمل عليها'),
            ),
            ListView.builder(
              itemCount: numbers.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(numbers[index]['name']),
                  subtitle: Text(numbers[index]['number']),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
