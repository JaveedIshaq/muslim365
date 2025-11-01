import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // Base font family
  static String get fontFamily => GoogleFonts.inter().fontFamily!;
  
  // Heading Styles
  static TextStyle get h1 => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  static TextStyle get h2 => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.3,
  );
  
  static TextStyle get h3 => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.2,
  );
  
  static TextStyle get h4 => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static TextStyle get h5 => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static TextStyle get h6 => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  // Body Text Styles
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
  
  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );
  
  // Label Styles
  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
  
  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
  
  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );
  
  // Button Text Styles
  static TextStyle get buttonLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  
  static TextStyle get buttonMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  
  static TextStyle get buttonSmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  
  // Caption and Overline
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );
  
  static TextStyle get overline => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 1.5,
  );
}