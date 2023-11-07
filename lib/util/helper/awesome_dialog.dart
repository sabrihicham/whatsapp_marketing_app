import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/langs.dart';
import 'dirction.dart';
import 'navigation.dart';

void myAwesomeDialog(
  BuildContext context, {
  required String title,
  required String content,
  required void Function() onTap,
}) {
  showDialog(
    context: context,
    builder: (context) {
      LangsController langsController = context.read<LangsController>();

      return Directionality(
        textDirection: getDirction(langsController.lang),
        child: AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.goBack();
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: onTap,
              child: const Text('موافق'),
            ),
          ],
        ),
      );
    },
  );
}
