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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
