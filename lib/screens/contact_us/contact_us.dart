import 'package:flutter/material.dart';
import '../../controller/langs.dart';
import '../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import '../../util/helper/navigation.dart';

import '../../controller/contact_us_controller.dart';

import '../login/widgets/login_button.dart';
import '../login/widgets/my_text_field.dart';

class ContactUsScreen extends StatelessWidget {
  static String routeName = 'contactUsScreen';

  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContactUsController contactUsControllerVars =
        context.watch<ContactUsController>();
    ContactUsController contactUsControllerFuncs =
        context.read<ContactUsController>();
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            context
                .watch<LangsController>()
                .langs[langsController.lang ?? 'ar']!['contact']!,
          ),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            children: [
              Text(
                context
                    .watch<LangsController>()
                    .langs[langsController.lang ?? 'ar']!['contact_us_head']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFAAAAAA),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                hintText: context
                    .watch<LangsController>()
                    .langs[langsController.lang ?? 'ar']!['userName']!,
                icon: Icons.person_rounded,
                controller: contactUsControllerVars.userName,
              ),
              MyTextField(
                hintText: context
                    .watch<LangsController>()
                    .langs[langsController.lang ?? 'ar']!['emailAddress']!,
                icon: Icons.email_rounded,
                controller: contactUsControllerVars.emailAddress,
              ),
              MyTextField(
                hintText: context
                    .watch<LangsController>()
                    .langs[langsController.lang ?? 'ar']!['phone']!,
                icon: Icons.phone_rounded,
                controller: contactUsControllerVars.phoneNumber,
              ),
              MyTextField(
                hintText: context
                    .watch<LangsController>()
                    .langs[langsController.lang ?? 'ar']!['phone_whatsapp']!,
                icon: Icons.phone_rounded,
                controller: contactUsControllerVars.whatsAppNumber,
              ),
              MyTextField(
                hintText: context
                    .watch<LangsController>()
                    .langs[langsController.lang ?? 'ar']!['contact_reson']!,
                icon: Icons.email_rounded,
                controller: contactUsControllerVars.reson,
              ),
              MyTextField(
                hintText: context
                    .watch<LangsController>()
                    .langs[langsController.lang ?? 'ar']!['message']!,
                icon: Icons.message_rounded,
                controller: contactUsControllerVars.message,
              ),
              const SizedBox(
                height: 20,
              ),
              LoginButton(
                text: context
                    .watch<LangsController>()
                    .langs[langsController.lang ?? 'ar']!['send']!,
                onPressed: () => contactUsControllerFuncs.sendContact(context),
              ),
              Text(
                context
                    .watch<LangsController>()
                    .langs[langsController.lang ?? 'ar']!['whatsapp_contact']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/whatsapp.png'),
                  ),
                ],
              ),
              Text(
                context
                    .watch<LangsController>()
                    .langs[langsController.lang ?? 'ar']!['phone_contact']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.phone),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
