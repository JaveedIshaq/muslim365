import 'package:flutter/material.dart';

/// Constants related to theme selection
class ThemeConstants {
  // Private constructor to prevent instantiation
  ThemeConstants._();

  // Theme titles
  static const String lightThemeTitle = 'Light';
  static const String darkThemeTitle = 'Dark';
  static const String systemThemeTitle = 'System';

  // Theme descriptions
  static const String lightThemeDescription = 'Light theme with bright colors';
  static const String darkThemeDescription = 'Dark theme with dark colors';
  static const String systemThemeDescription = 'Follow system theme setting';

  // UI strings
  static const String bottomSheetTitle = 'Theme';
  static const String selectedLabel = 'Selected';
  static const String themeChangedMessage = 'Theme changed to ';
  static const String undoLabel = 'Undo';

  // Animation durations
  static const int bottomSheetAnimationDuration = 300;
  static const int fadeInDuration = 200;
  static const int headerAnimationDuration = 400;
  static const int optionAnimationDuration = 400;
  static const int optionAnimationDelay = 100;
  static const int optionStaggerDelay = 50;
  static const int selectionAnimationDuration = 200;
  static const int closeDelayMs = 150;

  // Animation values
  static const double slideYBegin = 1.0;
  static const double slideYEnd = 0.0;
  static const double slideXBegin = 0.3;
  static const double slideXEnd = 0.0;
  static const double headerSlideYBegin = 0.3;
  static const double selectionScaleEnd = 1.1;

  // Visual constants
  static const double handleWidth = 36.0;
  static const double handleHeight = 4.0;
  static const double previewSize = 40.0;
  static const double handleOpacity = 0.4;
  static const double borderOpacity = 0.2;
  static const double selectedBackgroundOpacity = 0.1;
  static const double shadowOpacity = 0.1;
  static const double lightIconOpacity = 0.7;
  static const double darkIconOpacity = 0.9;

  // Theme colors
  static const Color lightPreviewColor = Color(0xFFFFFFFF);
  static const Color darkPreviewColor = Color(0xFF1C1C1E);
  static const Color systemPreviewColor = Color(0xFF6B38D4);

  // Shadow offset
  static const Offset shadowOffset = Offset(0, 2);
  static const double shadowBlurRadius = 4.0;

  // SnackBar duration
  static const Duration snackBarDuration = Duration(seconds: 2);
}