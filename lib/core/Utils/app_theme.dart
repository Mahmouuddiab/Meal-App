import 'package:flutter/material.dart';
import 'package:meal_app/core/Utils/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    primaryColor: AppColors.primary,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.primary),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      circularTrackColor: AppColors.gray.withOpacity(0.2),
      color: AppColors.primary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: AppColors.white, size: 30),
      unselectedIconTheme: IconThemeData(color: AppColors.primary, size: 30),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.gray,
      selectionColor: AppColors.blue.withOpacity(0.4),
      selectionHandleColor: AppColors.blue,
    ),
  );
}
