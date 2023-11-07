import 'package:flutter/material.dart';
import '../../../controller/langs.dart';
import '../../../util/helper/dirction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../controller/whatsapp/cubit/whatsapp_cubit.dart';
import 'package:whatsapp_marketing/screens/login/widgets/login_button.dart';
import 'package:whatsapp_marketing/screens/login/widgets/my_text_button.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key, required this.state});

  final WhatsappState state;

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.goBack();
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.goBack();
              },
              icon: const Icon(Icons.logout_rounded),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QrImageView(
                  data: widget.state.qr,
                  version: QrVersions.auto,
                  size: width * .8,
                ),
                Center(
                  child: MyTextButton(
                    text: langsController
                  .langs[langsController.lang ?? 'ar']!['refresh']!,
                    onPressed: context.read<WhatsappCubit>().getQR,
                    color: Colors.blueAccent,
                    alignment: MainAxisAlignment.center,
                  ),
                )
              ],
            ),
             Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      langsController
                  .langs[langsController.lang ?? 'ar']!['first_message']!),
                  Text(langsController
                  .langs[langsController.lang ?? 'ar']!['second_message']!),
                ],
              ),
            ),
            LoginButton(
                text: langsController
                  .langs[langsController.lang ?? 'ar']!['register_account']!,
                onPressed: context.read<WhatsappCubit>().submitQR),
          ],
        ),
      ),
    );
  }
}
