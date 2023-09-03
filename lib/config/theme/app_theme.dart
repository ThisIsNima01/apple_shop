import 'package:apple_shop/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.green,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
    )),
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        onPrimary: Colors.white,
        secondary: AppColors.green,
        onSecondary: Colors.white,
        error: AppColors.red,
        onError: Colors.white,
        background: AppColors.primaryColor,
        onBackground: Colors.black,
        surface: AppColors.lightContainerColor,
        onSurface: Colors.black),
    textTheme: TextTheme(
      titleSmall:
          TextStyle(color: AppColors.grey, fontSize: 12.sp, fontFamily: 'SB'),
      titleMedium: TextStyle(
          color: AppColors.primaryColor, fontSize: 14.sp, fontFamily: 'SB'),
      displayLarge: TextStyle(color: Colors.black, fontSize: 20.sp, fontFamily: 'SB'),
      labelLarge:
          TextStyle(color: Colors.white, fontSize: 18.sp, fontFamily: 'SB'),
      bodyLarge:
          TextStyle(color: AppColors.grey, fontSize: 16.sp, fontFamily: 'SB'),
      bodyMedium:
          TextStyle(color: AppColors.grey, fontSize: 14.sp, fontFamily: 'SB'),
      bodySmall:
          TextStyle(color: Colors.black, fontSize: 12.sp, fontFamily: 'SB'),
      labelSmall:
          TextStyle(color: Colors.white, fontSize: 10.sp, fontFamily: 'SB'),
    ),
  );
}
