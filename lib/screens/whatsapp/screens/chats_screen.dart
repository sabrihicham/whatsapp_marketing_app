import 'package:flutter/material.dart';
import '../../../controller/langs.dart';
import '../../../util/helper/dirction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../controller/whatsapp/cubit/whatsapp_cubit.dart';
import '../../../util/helper/navigation.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen(this.whatsappCubit, {super.key});

  static const String routeName = '/ChatsScreen';

  final WhatsappCubit whatsappCubit;

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.watch<LangsController>();

    return BlocConsumer<WhatsappCubit, WhatsappState>(
      bloc: widget.whatsappCubit,
      listener: (context, state) async {
        if (state.status == WhatsappStatus.sendingSuccess) {
          Fluttertoast.showToast(msg: langsController.langs[langsController.lang ?? 'ar']!['send_success']!);
          await showDialog(
            context: context, 
            builder: (_) => AlertDialog(
              title: Text(langsController.langs[langsController.lang ?? 'ar']!['send_success']!),
              content: Text(langsController.langs[langsController.lang ?? 'ar']!['send_success_msg']!),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  child: Text(langsController.langs[langsController.lang ?? 'ar']!['send_new_msg']!)
                ),
              ],
            )
          );
          widget.whatsappCubit.resetMessage();
          Navigator.of(context).pop(true);
        } else if (state.status == WhatsappStatus.sendingFailure) {}
      },
      builder: (context, state) {
        LangsController langsController = context.read<LangsController>();

        return Directionality(
          textDirection: getDirction(langsController.lang),
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                tooltip: 'ارسال',
                heroTag: 'send',
                onPressed: state.status == WhatsappStatus.sending
                    ? null
                    : () {
                      var total_chats = state.chats.where((element) => element.isGroup == false);
                      var selected_chats = total_chats.where((element) => state.isSelected(element.id!)).length;

                      var total_groups = state.chats.where((element) => element.isGroup == true);
                      var selected_groups =  total_groups.where((element) => state.isSelected(element.id!)).length;

                      showDialog(
                        context: context, 
                        builder: (_context) {
                          return AlertDialog(
                            title: Text(langsController.langs[langsController.lang ?? 'ar']!['send']!),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(langsController.langs[langsController.lang ?? 'ar']!['chats']!),
                                    const SizedBox(width: 10),
                                    Text("$selected_chats/${total_chats.length}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(langsController.langs[langsController.lang ?? 'ar']!['groups']!),
                                    const SizedBox(width: 10),
                                    Text("$selected_groups/${total_groups.length}"),
                                  ],
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(_context).pop();
                                }, 
                                child: Text(langsController.langs[langsController.lang ?? 'ar']!['cancel']!)
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(_context).pop();
                                  widget.whatsappCubit.sendMessage();
                                }, 
                                child: Text(langsController.langs[langsController.lang ?? 'ar']!['send']!)
                              ),
                            ],
                          );
                        });
                    },
                label: Text(state.status == WhatsappStatus.sending
                    ? langsController.langs[langsController.lang ?? 'ar']!['sending']!
                    : '${langsController.langs[langsController.lang ?? 'ar']!['send']!} (${state.selectedChatsCount})'),
                icon: state.status == WhatsappStatus.sending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Icon(Icons.send_rounded),
              ),
              appBar: AppBar(
                centerTitle: true,
                title: Text(langsController
                    .langs[langsController.lang ?? 'ar']!['select_dis']!),
                leading: IconButton(
                  onPressed: () {
                    context.goBack();
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                ),
                bottom: TabBar(
                  tabs: [
                    Text(
                        '${langsController.langs[langsController.lang ?? 'ar']!['all']!} (${state.chats.length})'),
                    Text(
                        '${langsController.langs[langsController.lang ?? 'ar']!['chats']!} (${state.onlyChats.length})'),
                    Text(
                        '${langsController.langs[langsController.lang ?? 'ar']!['groups']!} (${state.onlyGroups.length})'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Column(
                    children: [
                      CheckboxListTile(
                        value: state.selectAll,
                        onChanged: widget.whatsappCubit.selectAll,
                        title: Text(langsController.langs[
                            langsController.lang ?? 'ar']!['select_all']!),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.chats.length,
                          itemBuilder: (context, index) => CheckboxListTile(
                            value: state.isSelected(state.chats[index].id!),
                            onChanged: (value) {
                              widget.whatsappCubit.setSelected(
                                state.chats[index].id!,
                                value!,
                              );
                            },
                            title: Text(state.chats[index].name!),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CheckboxListTile(
                        value: state.selectOnlyChats,
                        onChanged: widget.whatsappCubit.selectOnlyChats,
                        title: Text(langsController.langs[
                            langsController.lang ??
                                'ar']!['select_all_chats']!),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.onlyChats.length,
                          itemBuilder: (context, index) => CheckboxListTile(
                            value: state.isSelected(state.onlyChats[index].id!),
                            onChanged: (value) {
                              widget.whatsappCubit.setSelected(
                                state.onlyChats[index].id!,
                                value!,
                              );
                            },
                            title: Text(state.onlyChats[index].name!),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CheckboxListTile(
                        value: state.selectOnlyGroups,
                        onChanged: widget.whatsappCubit.selectOnlyGroups,
                        title: Text(langsController.langs[
                            langsController.lang ??
                                'ar']!['select_all_groups']!),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.onlyGroups.length,
                          itemBuilder: (context, index) => CheckboxListTile(
                            value: state.isSelected(state.onlyGroups[index].id!),
                            onChanged: (value) {
                              widget.whatsappCubit.setSelected(
                                state.onlyGroups[index].id!,
                                value!,
                              );
                            },
                            title: Text(state.onlyGroups[index].name!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
