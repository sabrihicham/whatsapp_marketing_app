import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapp_marketing/controller/langs.dart';
import 'package:whatsapp_marketing/controller/whatsapp/cubit/whatsapp_cubit.dart';
import 'package:whatsapp_marketing/screens/login/widgets/login_button.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.watch<LangsController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            langsController.langs[langsController.lang ?? 'ar']!['error']!),
        leading: IconButton(
          onPressed: () {
            context.goBack();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<WhatsappCubit>().unlinkAccount();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            langsController
                .langs[langsController.lang ?? 'ar']!['error_message']!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            children: [
              LoginButton(
                text: langsController
                    .langs[langsController.lang ?? 'ar']!['try_again']!,
                onPressed: () {
                  context.read<WhatsappCubit>().isLinked();
                },
              ),
              const SizedBox(height: 20),
              LoginButton(
                text: langsController.langs[langsController.lang ?? 'ar']!['clear_data']!,
                onPressed: () async {
                  try {
                    await context.read<WhatsappCubit>().unlinkAccount(leave: false);
                    await Fluttertoast.showToast(
                      msg: langsController
                          .langs[langsController.lang ?? 'ar']!['data_cleared']!,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } catch (e) {
                    await Fluttertoast.showToast(
                      msg: langsController
                          .langs[langsController.lang ?? 'ar']!['data_clear_faild']!,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } finally {
                    await context.read<WhatsappCubit>().getQR();
                  }
                  
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
