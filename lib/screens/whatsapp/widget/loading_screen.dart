import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_marketing/controller/langs.dart';
import 'package:whatsapp_marketing/controller/whatsapp/cubit/whatsapp_cubit.dart';
import '../../../util/helper/navigation.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: context.read<WhatsappCubit>().unlinkAccount,
            tooltip: LangsController().langs[LangsController().lang ?? 'ar']!['clear_data']!,
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            context.goBack();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
