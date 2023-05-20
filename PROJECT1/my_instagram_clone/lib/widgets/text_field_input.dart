import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isPass = false,
      required this.textInputType});
  final bool isPass;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      keyboardType: textInputType,
      obscureText: isPass,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
    );
  }
}
