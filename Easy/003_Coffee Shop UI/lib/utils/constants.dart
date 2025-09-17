import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF4E342E);
  static const secondary = Color(0xFF795548);
  static const accent = Color(0xFFD7CCC8);
  static const background = Color(0xFFEFEBE9);
  static const textDark = Color(0xFF3E2723);
  static const textLight = Color(0xFFEFEBE9);
}

class AppTextStyles {
  static const headline1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  
  static const headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );
  
  static const bodyText = TextStyle(
    fontSize: 16,
    color: AppColors.textDark,
  );
  
  static const caption = TextStyle(
    fontSize: 14,
    color: AppColors.textDark,
  );
  
  static const price = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}