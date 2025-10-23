import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
