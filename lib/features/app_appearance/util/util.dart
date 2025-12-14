import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );

  // Merge display and body text themes for better typography
  TextTheme textTheme = displayTextTheme.copyWith(
    // Use body font for body text
    bodyLarge: bodyTextTheme.bodyLarge?.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodyMedium: bodyTextTheme.bodyMedium?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
    bodySmall: bodyTextTheme.bodySmall?.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.3,
    ),

    // Use display font for labels and buttons
    labelLarge: bodyTextTheme.labelLarge?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
    labelMedium: bodyTextTheme.labelMedium?.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
    labelSmall: bodyTextTheme.labelSmall?.copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
  );

  return textTheme;
}

// Enhanced text theme with custom dashboard styles
TextTheme createDashboardTextTheme(BuildContext context) {
  final baseTheme = createTextTheme(context, "Poppins", "Poppins");

  return baseTheme.copyWith(
    // Dashboard specific styles
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      height: 1.2,
      letterSpacing: -0.5,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      height: 1.2,
      letterSpacing: -0.3,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
  );
}
