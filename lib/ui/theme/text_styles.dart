import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextStyles {
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Geist',
    fontSize: 34,
    fontWeight: FontWeight.w900, // Geist-Black
    color: AppColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Geist',
    fontSize: 30,
    fontWeight: FontWeight.w800, // Geist-UltraBlack
    color: AppColors.textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Geist',
    fontSize: 26,
    fontWeight: FontWeight.w700, // Geist-Bold
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Geist',
    fontSize: 24,
    fontWeight: FontWeight.w600, // Geist-SemiBold
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Geist',
    fontSize: 22,
    fontWeight: FontWeight.w500, // Geist-Medium
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Geist',
    fontSize: 18,
    fontWeight: FontWeight.w400, // Geist-Regular
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Geist',
    fontSize: 16,
    fontWeight: FontWeight.w300, // Geist-Light
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Geist',
    fontSize: 14,
    fontWeight: FontWeight.w200, // Geist-Thin
    color: AppColors.textSecondary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Geist',
    fontSize: 20,
    fontWeight: FontWeight.w100, // Geist-UltraLight
    color: AppColors.textPrimary,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontFamily: 'Geist',
    fontSize: 20,
    fontWeight: FontWeight.w600, // Geist-SemiBold
    color: AppColors.white,
  );
}
