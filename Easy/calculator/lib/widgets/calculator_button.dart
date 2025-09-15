import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isLarge;

  const CalculatorButton({
    super.key,
    required this.text,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    required this.onPressed,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          minimumSize: Size(isLarge ? 150 : 70, 70),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}