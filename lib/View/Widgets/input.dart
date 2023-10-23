import 'package:contact_book/Model/Constants/color.dart';
import 'package:flutter/material.dart';

class Inputs extends StatelessWidget {
  final TextEditingController? controller;
  final Color? themeColor;
  final String? hint;
  final ValueChanged<String>? onChanged;

  const Inputs({
    super.key,
    this.controller,
    this.themeColor,
    this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color color = themeColor ?? AppColor.black;
    String text = hint ?? '';

    Widget label = Text(text);

    OutlineInputBorder border =
        OutlineInputBorder(borderSide: BorderSide(color: color));

    InputDecoration decoration = InputDecoration(border: border, label: label);

    return TextField(
      controller: controller,
      decoration: decoration,
      onChanged: onChanged,
    );
  }
}
