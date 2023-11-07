import 'package:flutter/material.dart';

import '../../../util/colors.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final MainAxisAlignment? alignment;
  final void Function()? onPressed;
  final Color? color;
  const MyTextButton({
    super.key,
    required this.text,
    this.alignment,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment ?? MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 16,
              color: color ?? MyColors.hintColor,
            ),
          ),
        ),
      ],
    );
  }
}
