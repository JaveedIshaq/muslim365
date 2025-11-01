import 'package:flutter/material.dart';

/// Constants related to language selection
class LanguageConstants {
  // Private constructor to prevent instantiation
  LanguageConstants._();

  // UI strings
  static const String bottomSheetTitle = 'Language';
  static const String selectedLabel = 'Selected';
  static const String languageChangedMessage = 'Language changed to ';
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
  static const double flagSize = 40.0;
  static const double handleOpacity = 0.4;
  static const double borderOpacity = 0.2;
  static const double selectedBackgroundOpacity = 0.1;
  static const double shadowOpacity = 0.1;

  // Shadow offset
  static const Offset shadowOffset = Offset(0, 2);
  static const double shadowBlurRadius = 4.0;

  // SnackBar duration
  static const Duration snackBarDuration = Duration(seconds: 2);
}