import 'package:contact_book/Model/Constants/color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final String title;
  final GestureTapCallback? onTap;

  const CustomButton({
    super.key,
    this.buttonColor = AppColor.black,
    this.textColor = AppColor.white,
    this.title = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Center(
      child: Text(
        title,
        style: TextStyle(color: textColor),
      ),
    );

    BoxDecoration decoration = BoxDecoration(
      color: buttonColor,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: decoration,
        child: child,
      ),
    );
  }
}
