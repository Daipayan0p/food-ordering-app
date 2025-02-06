import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/app/theme/app_color.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.backGround, // Light grey background
    primaryColor: const Color(0xFF4D81F1), // Blue primary color
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF4D81F1), // Blue app bar
      foregroundColor: Colors.white, // White text/icons
      elevation: 0,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF84D76B), // Green buttons
      textTheme: ButtonTextTheme.primary, // Primary button text style
    ),
    cardColor: Colors.white, // White card background
  );
}