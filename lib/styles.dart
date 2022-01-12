import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// Convenience class to access application colors.
abstract class AppColors {
  /// Dark background color.
  static const Color backgroundColor = Color.fromRGBO(225,225, 225, 100);

  /// Slightly lighter version of [backgroundColor].
  static const Color backgroundFadedColor = Color.fromRGBO(225,225, 225, 100);//fromRGBO(int r, int g, int b, double opacity);//Color(0xFF191B1C);

  /// Color used for cards and surfaces.
  static const Color cardColor = Colors.white;//Color(0xFF1F2426);

  /// Accent color used in the application.
  static const Color accentColor = Color(0xFFef8354);
  static const Color mainColor = Color.fromRGBO(41,93, 97, 100);

}
