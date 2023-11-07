import 'package:flutter/material.dart';
import '../../../controller/langs.dart';
import '../../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import 'upload_image.dart';
import '../../../util/helper/navigation.dart';

import '../../../controller/discount_controller.dart';
import '../../../controller/packages_controller.dart';
import '../../../util/colors.dart';
import '../../imported_messages/widgets/my_text_rich.dart';
import '../../login/widgets/login_button.dart';

class PaymentRequestScreen extends StatelessWidget {
  static const String routeName = 'payment_requestScreen';

  const PaymentRequestScreen(
      {super.key,
      required this.packageName,
      required this.packagePrice,
      required this.discountValue});
  final String packageName, packagePrice;
  final int discountValue;
  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(langsController
              .langs[langsController.lang ?? 'ar']!['pay_request']!),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 25,
            right: 15,
            left: 15,
          ),
          child: Column(
            children: [
              Text(
                langsController.langs[langsController.lang ?? 'ar']![
                    'pay_request_notice']!,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: MyColors.hintColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Text(
                      "الدفع عن طريق :",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: context.read<PackagesController>().getMethods(),
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
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return MyTextRich(
                                keyT:
                                    "${snapshot.data!.docs[index]['name']}  :  ",
                                value: snapshot.data!.docs[index]['number']);
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
              LoginButton(
                  text: langsController
                      .langs[langsController.lang ?? 'ar']!['pay_now']!,
                  onPressed: () => context.goTo(
                        UploadImage(
                          packageName: packageName,
                          packagePrice: packagePrice,
                          discountCode: context
                              .read<DisCountController>()
                              .discountCode
                              .text,
                          priceAfterDiscount: context
                              .read<DisCountController>()
                              .priceAfterDiscount(packagePrice, discountValue),
                        ),
                      )),
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
