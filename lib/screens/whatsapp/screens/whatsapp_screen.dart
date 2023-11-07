import 'package:flutter/material.dart';
import '../../../controller/whatsapp/cubit/whatsapp_cubit.dart';
import '../widget/error_screen.dart';
import '../widget/loading_screen.dart';
import '../widget/qr_screen.dart';
import '../widget/send_message_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../util/helper/navigation.dart';

class WhatsappScreen extends StatefulWidget {
  const WhatsappScreen({super.key, this.tag = 'N'});

  static const String routeName = '/WhatsappScreen';

  final String tag;

  @override
  State<WhatsappScreen> createState() => _WhatsappScreenState();
}

class _WhatsappScreenState extends State<WhatsappScreen> {
  late WhatsappCubit whatsappCubit;

  @override
  void initState() {
    whatsappCubit = WhatsappCubit(widget.tag);
    whatsappCubit.isLinked();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => whatsappCubit,
      child: BlocConsumer<WhatsappCubit, WhatsappState>(
        listener: (context, state) {
          if (state.status == WhatsappStatus.unLinkingSuccess) {
            context.goBack();
          }
        },
        builder: (context, state) {
          if (state.status == WhatsappStatus.loading ||
              state.status == WhatsappStatus.initial) {
            return const LoadingScreen();
          }
          if (state.status == WhatsappStatus.error) {
            return const ErrorScreen();
          }
          if (state.status == WhatsappStatus.notLinked) {
            return QRScreen(state: state);
          }
          return SendMessageScreen(state: state);
        },
      ),
    );
  }
}
