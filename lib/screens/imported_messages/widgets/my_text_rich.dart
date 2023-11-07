import 'package:flutter/material.dart';

class MyTextRich extends StatelessWidget {
  const MyTextRich({
    super.key,
    required this.keyT,
    required this.value,
  });

  final String keyT, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          text: keyT,
          children: <TextSpan>[
            TextSpan(
              style: const TextStyle(
                color: Color(0xFFAAAAAA),
              ),
              text: value,
            ),
          ],
        ),
      ),
    );
  }
}
