import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../util/helper/media_query.dart';

import '../../../controller/sms_controller.dart';

class MyTapViewItem extends StatelessWidget {
  const MyTapViewItem({
    super.key,
    required this.text,
    required this.id,
  });

  final String text;

  final int id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SMSController>().selectItem(id);
        context.read<SMSController>().getContacts();
      },
      child: Container(
        width: context.getWidth() / 3,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: id == context.watch<SMSController>().selectedItem
              ? Colors.blue.shade300
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: id == context.watch<SMSController>().selectedItem
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        )),
      ),
    );
  }
}
