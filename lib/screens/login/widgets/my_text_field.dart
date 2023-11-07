import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final int? maxLines, minLines, maxLength;
  final TextInputType? inputType;
  final IconData icon;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;

  const MyTextField(
      {super.key,
      required this.hintText,
      this.maxLines,
      this.minLines,
      this.inputType,
      required this.icon,
      required this.controller,
      this.textInputAction,
      this.contentPadding,
      this.maxLength,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 8,
          ),
          child: TextFormField(
            focusNode: focusNode,
            keyboardType: inputType ?? TextInputType.text,
            controller: controller,
            maxLines: maxLines, // Allows multiline input
            minLines: minLines ?? 1, // Set the minimum number of lines
            maxLength: maxLength,
            textInputAction: textInputAction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              prefixIcon: Icon(icon),
              contentPadding: contentPadding,
            ),
          ),
        ),
      ),
    );
  }
}
