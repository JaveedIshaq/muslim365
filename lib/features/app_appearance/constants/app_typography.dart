import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Typography Constants
///
/// Centralized typography system using Poppins font family.
/// This ensures consistent typography across the entire NurseLife app.
///
/// Usage:
/// ```dart
/// Text('Hello', style: AppTypography.h1)
/// Text('Body text', style: AppTypography.bodyMedium)
/// ```
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  // Base font family - Poppins (matches Material Theme Builder)
  static String get fontFamily => GoogleFonts.poppins().fontFamily!;

  // ===== DISPLAY STYLES =====
  /// Display Large - 32px, Bold
  static TextStyle get displayLarge => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  /// Display Medium - 28px, Bold
  static TextStyle get displayMedium => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.3,
  );

  /// Display Small - 24px, SemiBold
  static TextStyle get displaySmall => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.2,
  );

  // ===== HEADING STYLES =====
  /// Heading 1 - 32px, Bold (alias for displayLarge)
  static TextStyle get h1 => displayLarge;

  /// Heading 2 - 28px, SemiBold (alias for displayMedium)
  static TextStyle get h2 => displayMedium;

  /// Heading 3 - 24px, SemiBold (alias for displaySmall)
  static TextStyle get h3 => displaySmall;

  /// Heading 4 - 20px, SemiBold
  static TextStyle get h4 => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Heading 5 - 18px, SemiBold
  static TextStyle get h5 => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Heading 6 - 16px, SemiBold
  static TextStyle get h6 => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ===== TITLE STYLES =====
  /// Title Large - 18px, SemiBold (alias for h5)
  static TextStyle get titleLarge => h5;

  /// Title Medium - 16px, SemiBold (alias for h6)
  static TextStyle get titleMedium => h6;

  /// Title Small - 14px, Medium
  static TextStyle get titleSmall => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // ===== BODY TEXT STYLES =====
  /// Body Large - 16px, Regular
  static TextStyle get bodyLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Body Medium - 14px, Regular
  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// Body Small - 12px, Regular
  static TextStyle get bodySmall => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  // ===== LABEL STYLES =====
  /// Label Large - 14px, Medium
  static TextStyle get labelLarge => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  /// Label Medium - 12px, Medium
  static TextStyle get labelMedium => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  /// Label Small - 10px, Medium
  static TextStyle get labelSmall => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  // ===== BUTTON TEXT STYLES =====
  /// Button Large - 16px, SemiBold
  static TextStyle get buttonLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  /// Button Medium - 14px, SemiBold
  static TextStyle get buttonMedium => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  /// Button Small - 12px, SemiBold
  static TextStyle get buttonSmall => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // ===== SPECIALIZED STYLES =====
  /// Caption - 12px, Regular
  static TextStyle get caption => bodySmall;

  /// Overline - 10px, Medium, with letter spacing
  static TextStyle get overline => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 1.5,
  );

  // ===== DASHBOARD SPECIFIC STYLES =====
  /// Dashboard Greeting - 28px, Bold
  static TextStyle get dashboardGreeting => displayMedium;

  /// Stats Number - 24px, Bold
  static TextStyle get statsNumber => displaySmall;

  /// Card Title - 20px, SemiBold
  static TextStyle get cardTitle => h4;

  /// Card Subtitle - 14px, Regular
  static TextStyle get cardSubtitle => bodyMedium;

  /// Button Label - 12px, Medium
  static TextStyle get buttonLabel => labelSmall;

  /// Earnings Amount - 16px, SemiBold
  static TextStyle get earningsAmount => h6.copyWith(
    fontWeight: FontWeight.w600,
  );

  /// Shift Time - 16px, SemiBold
  static TextStyle get shiftTime => earningsAmount;

  /// Status Badge - 11px, SemiBold
  static TextStyle get statusBadge => GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // ===== HELPER METHODS =====
  /// Apply color to text style
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Apply font weight to text style
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Apply font size to text style
  static TextStyle withSize(TextStyle style, double fontSize) {
    return style.copyWith(fontSize: fontSize);
  }
}

/// Extension methods for easy TextStyle manipulation
extension AppTypographyExtensions on TextStyle {
  /// Apply color
  TextStyle withColor(Color color) => AppTypography.withColor(this, color);

  /// Apply font weight
  TextStyle withWeight(FontWeight weight) => AppTypography.withWeight(this, weight);

  /// Apply font size
  TextStyle withSize(double fontSize) => AppTypography.withSize(this, fontSize);
}