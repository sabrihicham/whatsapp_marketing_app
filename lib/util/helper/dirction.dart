import 'package:flutter/material.dart';

TextDirection getDirction(String? lang) {
  if (lang == null) {
    return TextDirection.rtl;
  } else {
    if (lang == 'ar') {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }
}
