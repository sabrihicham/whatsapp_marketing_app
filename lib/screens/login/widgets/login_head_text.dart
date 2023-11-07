import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_marketing/controller/langs.dart';

import '../../../util/colors.dart';

class LoginHeadText extends StatelessWidget {
  final String title, hint;
  const LoginHeadText({
    super.key,
    required this.title,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              hint,
              style: const TextStyle(
                color: MyColors.hintColor,
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: context.read<LangsController>().changeLang, 
          child: Text(
            (context.read<LangsController>().lang ?? 'ar') == 'ar' ? 'English' : 'العربية',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        )
      ],
    );
  }
}
