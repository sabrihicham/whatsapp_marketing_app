import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final double? width, fontSize;
  final void Function()? onPressed;
  const LoginButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width ?? (MediaQuery.of(context).size.width / 3) * 2,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize ?? 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
