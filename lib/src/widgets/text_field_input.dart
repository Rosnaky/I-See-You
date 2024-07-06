import 'package:ISeeYou/src/utils/theme.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput(
      {super.key,
      this.obscureText = false,
      required this.hintText,
      required this.controller,
      required this.textInputType});

  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: myTheme.textTheme.bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
