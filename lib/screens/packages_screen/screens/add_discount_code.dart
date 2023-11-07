import 'package:flutter/material.dart';
import '../../../controller/langs.dart';
import '../../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import '../../login/widgets/my_text_field.dart';
import 'payment_request.dart';
import '../../../util/helper/navigation.dart';

import '../../../controller/discount_controller.dart';
import '../../login/widgets/login_button.dart';
import '../../login/widgets/login_head_text.dart';

class DiscoundCode extends StatelessWidget {
  const DiscoundCode(
      {super.key, required this.packageName, required this.packagePrice});
  final String packageName, packagePrice;

  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              langsController.langs[langsController.lang ?? 'ar']!['code']!),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 45, 20, 10),
            children: [
              LoginHeadText(
                title: langsController
                    .langs[langsController.lang ?? 'ar']!['use_code']!,
                hint: langsController
                    .langs[langsController.lang ?? 'ar']!['code_notice']!,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                hintText: langsController
                    .langs[langsController.lang ?? 'ar']!['enter_code']!,
                icon: Icons.discount_rounded,
                controller: context.watch<DisCountController>().discountCode,
              ) // password
              ,
              const SizedBox(
                height: 20,
              ),
              LoginButton(
                text: langsController
                    .langs[langsController.lang ?? 'ar']!['start_code']!,
                onPressed: () => context.read<DisCountController>().doDiscound(
                    context,
                    packageName: packageName,
                    packagePrice: packagePrice),
              ),
              const SizedBox(
                height: 10,
              ),
              LoginButton(
                text: langsController
                    .langs[langsController.lang ?? 'ar']!['skip']!,
                onPressed: () => context.goTo(PaymentRequestScreen(
                  packageName: packageName,
                  packagePrice: packagePrice,
                  discountValue: 0,
                )),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
