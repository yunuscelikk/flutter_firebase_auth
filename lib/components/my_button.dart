import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final onPressed;
  final String text;
  final backgroundColor;

  const MyButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
    );
  }
}
