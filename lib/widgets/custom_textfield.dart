import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final TextEditingController controller;
  const CustomTextField({Key? key, required this.hintText, required this.keyboardType, required this.textCapitalization, required this.maxLines, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none
        ),
        filled: true,
        fillColor: const Color(0xff29404E),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white54
        ),
      ),
      style: const TextStyle(
          color: Colors.white70
      ),
      cursorColor: Colors.white70,
      maxLines: maxLines,
      minLines: 1,
    );
  }
}
