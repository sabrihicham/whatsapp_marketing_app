import 'package:flutter/material.dart';
import '../../../controller/langs.dart';
import '../../../util/helper/dirction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/whatsapp/cubit/whatsapp_cubit.dart';
import '../../login/widgets/login_button.dart';
import '../../login/widgets/my_text_button.dart';
import '../../login/widgets/my_text_field.dart';
import '../screens/chats_screen.dart';
import '../../../util/helper/navigation.dart';

class SendMessageScreen extends StatefulWidget {
  const SendMessageScreen({super.key, required this.state});

  final WhatsappState state;

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: context.read<WhatsappCubit>().pickFile,
          child: const Icon(Icons.attachment),
        ),
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
              context.goBack();
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // myAwesomeDialog(
                  //   context,
                  //   title: 'إلغاء الربط',
                  //   content:
                  //       'هل أنت متأكد أنك تريد إلغاء ربط حسابك على الواتساب؟',
                  //   onTap: context.read<WhatsappCubit>().unlinkAccount,
                  // );
                  context.read<WhatsappCubit>().unlinkAccount();
                },
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: MyTextField(
                hintText: langsController
                    .langs[langsController.lang ?? 'ar']!['message']!,
                icon: Icons.message_rounded,
                maxLines: null,
                minLines: 4,
                inputType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                // maxLength: 150,
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                controller: widget.state.messageController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
              child: MyTextField(
                hintText: langsController
                    .langs[langsController.lang ?? 'ar']!['link']!,
                icon: Icons.link_rounded,
                controller: widget.state.linkController,
              ),
            ),
            if (widget.state.status == WhatsappStatus.uploadingFile)
              const Row(
                children: [
                  SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator()),
                ],
              ),
            if (widget.state.url != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextButton(
                    text: langsController
                        .langs[langsController.lang ?? 'ar']!['doc_uploaded']!,
                    onPressed: null,
                  ),
                  MyTextButton(
                    text: langsController
                        .langs[langsController.lang ?? 'ar']!['cancel']!,
                    color: Colors.red,
                    onPressed: context.read<WhatsappCubit>().deleteFile,
                  )
                ],
              ),
            if (widget.state.location != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextButton(
                    text: langsController
                        .langs[langsController.lang ?? 'ar']!['loc_add']!,
                    onPressed: context.read<WhatsappCubit>().pickLocation,
                  ),
                  MyTextButton(
                    text: langsController
                    .langs[langsController.lang ?? 'ar']!['cancel']!,
                    color: Colors.red,
                    onPressed: context.read<WhatsappCubit>().deleteLocation,
                  )
                ],
              )
            else
              MyTextButton(
                text: langsController.langs[langsController.lang ?? 'ar']!['add_loc']!,
                onPressed: context.read<WhatsappCubit>().pickLocation,
              ),
            LoginButton(
              onPressed: () async {
                var whatsappCubit = context.read<WhatsappCubit>();
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatsScreen(whatsappCubit),
                  )
                ).then((value) async {
                  if (value == true) {
                    context.read<WhatsappCubit>().deleteLocationAndFile();
                  }
                });

              },
              text: langsController
                  .langs[langsController.lang ?? 'ar']!['select']!,
            ),
          ],
        ),
      ),
    );
  }
}
