import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_marketing/controller/langs.dart';
import '../../controller/sign_in_controller.dart';
import 'signup_screen.dart';
import 'widgets/my_text_button.dart';
import 'package:whatsapp_marketing/screens/login/widgets/my_text_field.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';

import '../../util/images.dart';
import 'forgot_pass.dart';
import 'widgets/login_button.dart';
import 'widgets/login_head_text.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'loginScreen';
  const LoginScreen({super.key});

  TextDirection getDirction(String? lang) {
    if (lang != 'ar') {
      return TextDirection.ltr;
    } else {
      return TextDirection.rtl;
    }
  }

  @override
  Widget build(BuildContext context) {
    SignInController controller = context.watch<SignInController>();

    LangsController langsController = context.watch<LangsController>();
    
    return Scaffold(
      body: Directionality(
        textDirection: getDirction(langsController.lang),
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 45, 20, 10),
            children: [
              LoginHeadText(
                  title: langsController
                      .langs[langsController.lang ?? 'ar']!['login']!,
                  hint: langsController
                      .langs[langsController.lang ?? 'ar']!['welcome']!),
              Image.asset(MyImages.logoLink),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                hintText: langsController
                    .langs[langsController.lang ?? 'ar']!['emailAddress']!,
                icon: Icons.email_rounded,
                controller: controller.emailAddress,
              ),
      
              // password
              MyTextField(
                hintText: langsController
                    .langs[langsController.lang ?? 'ar']!['password']!,
                icon: Icons.key_rounded,
                controller: controller.password,
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: false,
                child: MyTextButton(
                  text: langsController.langs[langsController.lang ?? 'ar']!['resetQ']!,
                  onPressed: () => context.goToNamed(ForgotScreen.routeName),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              LoginButton(
                text: langsController
                    .langs[langsController.lang ?? 'ar']!['login']!,
                onPressed: () {
                  // Navigator.pushNamed(context, HomeScreen.routeName);
                  context.read<SignInController>().login(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextButton(
                text: langsController
                    .langs[langsController.lang ?? 'ar']!['dontacc']!,
                alignment: MainAxisAlignment.center,
                onPressed: () {
                  context.goToNamed(SignUpScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
