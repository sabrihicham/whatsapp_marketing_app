import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/langs.dart';
import '../../../controller/upload_image_controller.dart';
import '../../../util/helper/dirction.dart';
import '../../../util/helper/navigation.dart';
import '../../login/widgets/login_button.dart';

class UploadImage extends StatelessWidget {
  const UploadImage(
      {super.key,
      required this.packageName,
      required this.packagePrice,
      required this.priceAfterDiscount,
      this.discountCode});
  final String? packageName, packagePrice, priceAfterDiscount, discountCode;

  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('إرفاق الإيصال'),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: ListView(
          padding:
              const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
          children: [
            Text(
              int.parse(priceAfterDiscount!) != 0
                  ? 'تأكد من إتمام دفع مبلغ قدره $priceAfterDiscount من اصل $packagePrice قبل البدأ في إرفاق الإيصال و سيتم الرد عليك بعد المراحعة من قبل الإدارة'
                  : 'تأكد من إتمام دفع مبلغ قدره $packagePrice  قبل البدأ في إرفاق الإيصال و سيتم الرد عليك بعد المراحعة من قبل الإدارة',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFFAAAAAA),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: InkWell(
                  onTap: () => context.read<UploadImageController>().getImage(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      color: const Color(0xFFAAAAAA),
                      child: context.watch<UploadImageController>().isloading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : context
                                      .watch<UploadImageController>()
                                      .downloadLink !=
                                  null
                              ? Image.network(context
                                  .watch<UploadImageController>()
                                  .downloadLink!)
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.insert_photo_rounded,
                                      size: 55,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'أرفق صورة الإيصال',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            LoginButton(
              text: 'حفظ',
              onPressed: () => context
                  .read<UploadImageController>()
                  .addImageToFirestore(context,
                      price: packagePrice!, discountCode: discountCode ?? ''),
            )
          ],
        ),
      ),
    );
  }
}
