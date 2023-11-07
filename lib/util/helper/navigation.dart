import 'package:flutter/material.dart';

extension MyNavigation on BuildContext {
  void goToNamed(String routeName, {dynamic arg}) => Navigator.pushNamed(this, routeName, arguments: arg);
  void goTo(Widget page) => Navigator.push(
    this,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
  void goReplacementNamed(String routeName) =>
      Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false);
  void goBack() => Navigator.maybePop(this);
}
