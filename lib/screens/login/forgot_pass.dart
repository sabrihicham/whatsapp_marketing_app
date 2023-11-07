import 'package:flutter/material.dart';
import '../../controller/langs.dart';
import 'package:provider/provider.dart';
import 'widgets/login_button.dart';
import '../../util/helper/navigation.dart';

import '../../controller/sign_in_controller.dart';
import '../../util/images.dart';
import 'widgets/login_head_text.dart';
import 'widgets/my_text_button.dart';

class ForgotScreen extends StatelessWidget {
  static const String routeName = 'forgotScreen';

  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignInController controller = context.watch<SignInController>();

    LangsController langsController = context.read<LangsController>();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 45, 20, 10),
          children: [
            LoginHeadText(
              title: langsController
                  .langs[langsController.lang ?? 'ar']!['newPass']!,
              hint: langsController
                  .langs[langsController.lang ?? 'ar']!['entEmail']!,
            ),

            Image.asset(MyImages.logoLink),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 10,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 8,
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailAddress,
                  decoration: InputDecoration(
                    hintText: langsController
                        .langs[langsController.lang ?? 'ar']!['emailAddress']!,
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.email_rounded),
                  ),
                ),
              ),
            ),
            // password
            const SizedBox(
              height: 20,
            ),
            LoginButton(
              text: langsController.langs[langsController.lang ?? 'ar']!['resetP']!,
              onPressed: () => context.read<SignInController>().returnPassword(context),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextButton(
              text: langsController
                  .langs[langsController.lang ?? 'ar']!['haveAcc']!,
              onPressed: () => context.goBack(),
            ),
          ],
        ),
      ),
    );
  }
}
