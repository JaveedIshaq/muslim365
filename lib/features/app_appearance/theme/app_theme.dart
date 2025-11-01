/// Material Design 3 compliant theme implementation
///
/// This theme follows Google's Material Design 3 guidelines and provides:
/// - Complete M3 color schemes with all semantic roles
/// - Surface tinting and dynamic color support
/// - Comprehensive component theming
/// - Accessibility-first design
/// - State-based interactions
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.lightTheme,
///   darkTheme: AppTheme.darkTheme,
///   // ...
/// );
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_typography.dart';
import '../constants/app_dimensions.dart';

class AppTheme {
  // Material Design 3 compliant color schemes
  static ColorScheme lightColorScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff6b38d4),
      surfaceTint: Color(0xff6d3bd7),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff8455ef),
      onPrimaryContainer: Color(0xfffffbff),
      secondary: Color(0xff665396),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffc9b3fd),
      onSecondaryContainer: Color(0xff544183),
      tertiary: Color(0xff6b38d4),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8455ef),
      onTertiaryContainer: Color(0xfffffbff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff1d1a23),
      onSurfaceVariant: Color(0xff494454),
      outline: Color(0xff7b7486),
      outlineVariant: Color(0xffcbc3d7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f39),
      inversePrimary: Color(0xffd0bcff),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff23005c),
      primaryFixedDim: Color(0xffd0bcff),
      onPrimaryFixedVariant: Color(0xff5516be),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff220b4e),
      secondaryFixedDim: Color(0xffd0bcff),
      onSecondaryFixedVariant: Color(0xff4e3b7c),
      tertiaryFixed: Color(0xffe9ddff),
      onTertiaryFixed: Color(0xff23005c),
      tertiaryFixedDim: Color(0xffd0bcff),
      onTertiaryFixedVariant: Color(0xff5516be),
      surfaceDim: Color(0xffded7e4),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f1fe),
      surfaceContainer: Color(0xfff3ebf8),
      surfaceContainerHigh: Color(0xffede5f3),
      surfaceContainerHighest: Color(0xffe7e0ed),
    );
  }

  static ColorScheme darkColorScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd0bcff),
      surfaceTint: Color(0xffd0bcff),
      onPrimary: Color(0xff3c0091),
      primaryContainer: Color(0xffa078ff),
      onPrimaryContainer: Color(0xff14003b),
      secondary: Color(0xffd0bcff),
      onSecondary: Color(0xff372464),
      secondaryContainer: Color(0xff513e7f),
      onSecondaryContainer: Color(0xffc3adf7),
      tertiary: Color(0xffd0bcff),
      onTertiary: Color(0xff3c0091),
      tertiaryContainer: Color(0xffa078ff),
      onTertiaryContainer: Color(0xff14003b),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff15121b),
      onSurface: Color(0xffe7e0ed),
      onSurfaceVariant: Color(0xffcbc3d7),
      outline: Color(0xff958ea0),
      outlineVariant: Color(0xff494454),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe7e0ed),
      inversePrimary: Color(0xff6d3bd7),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff23005c),
      primaryFixedDim: Color(0xffd0bcff),
      onPrimaryFixedVariant: Color(0xff5516be),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff220b4e),
      secondaryFixedDim: Color(0xffd0bcff),
      onSecondaryFixedVariant: Color(0xff4e3b7c),
      tertiaryFixed: Color(0xffe9ddff),
      onTertiaryFixed: Color(0xff23005c),
      tertiaryFixedDim: Color(0xffd0bcff),
      onTertiaryFixedVariant: Color(0xff5516be),
      surfaceDim: Color(0xff15121b),
      surfaceBright: Color(0xff3b3742),
      surfaceContainerLowest: Color(0xff0f0d15),
      surfaceContainerLow: Color(0xff1d1a23),
      surfaceContainer: Color(0xff211e27),
      surfaceContainerHigh: Color(0xff2c2832),
      surfaceContainerHighest: Color(0xff37333d),
    );
  }

  /// Builds a ThemeData from a ColorScheme - eliminates redundancy between light/dark themes
  static ThemeData _buildTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      fontFamily: AppTypography.fontFamily,
      colorScheme: colorScheme,

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.h5.copyWith(color: colorScheme.onSurface),
        systemOverlayStyle: colorScheme.brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        surfaceTintColor: colorScheme.surfaceTint,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainer,
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        margin: const EdgeInsets.all(AppDimensions.marginSM),
        surfaceTintColor: colorScheme.surfaceTint,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHigh,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMD,
          vertical: AppDimensions.paddingMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        labelStyle: AppTypography.labelMedium.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.onSurface.withValues(
            alpha: 0.12,
          ),
          disabledForegroundColor: colorScheme.onSurface.withValues(
            alpha: 0.38,
          ),
          minimumSize: const Size(
            double.infinity,
            AppDimensions.buttonHeightMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
          textStyle: AppTypography.buttonMedium,
          elevation: 1,
          shadowColor: colorScheme.shadow,
        ),
      ),

      // Filled Button Theme (Material 3)
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.onSurface.withValues(
            alpha: 0.12,
          ),
          disabledForegroundColor: colorScheme.onSurface.withValues(
            alpha: 0.38,
          ),
          minimumSize: const Size(
            double.infinity,
            AppDimensions.buttonHeightMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
          textStyle: AppTypography.buttonMedium,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.onSurface.withValues(
            alpha: 0.38,
          ),
          textStyle: AppTypography.buttonMedium,
          minimumSize: const Size(0, AppDimensions.buttonHeightMD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.onSurface.withValues(
            alpha: 0.38,
          ),
          side: BorderSide(color: colorScheme.outline),
          minimumSize: const Size(
            double.infinity,
            AppDimensions.buttonHeightMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
          textStyle: AppTypography.buttonMedium,
        ),
      ),

      // Icon Button Theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: colorScheme.onSurfaceVariant,
          disabledForegroundColor: colorScheme.onSurface.withValues(
            alpha: 0.38,
          ),
          highlightColor: colorScheme.primary.withValues(alpha: 0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
          ),
        ),
      ),

      // FAB Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 6,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSecondaryContainer,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 3,
      ),

      // Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.secondaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.labelMedium.copyWith(
              color: colorScheme.onSurface,
            );
          }
          return AppTypography.labelMedium.copyWith(
            color: colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.onSecondaryContainer);
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant);
        }),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        titleTextStyle: AppTypography.h5.copyWith(color: colorScheme.onSurface),
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: AppDimensions.dividerThickness,
        space: AppDimensions.dividerHeight,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.surfaceContainerHighest,
        circularTrackColor: colorScheme.surfaceContainerHighest,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        selectedColor: colorScheme.secondaryContainer,
        deleteIconColor: colorScheme.onSurfaceVariant,
        disabledColor: colorScheme.onSurface.withValues(alpha: 0.12),
        labelStyle: AppTypography.labelMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        secondaryLabelStyle: AppTypography.labelMedium.copyWith(
          color: colorScheme.onSecondaryContainer,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: colorScheme.outline),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onPrimary;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.surfaceContainerHighest;
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.surfaceContainerHighest,
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withValues(alpha: 0.12),
        valueIndicatorColor: colorScheme.inverseSurface,
        valueIndicatorTextStyle: AppTypography.labelMedium.copyWith(
          color: colorScheme.onInverseSurface,
        ),
      ),

      // Text Theme with Material 3 roles
      textTheme: TextTheme(
        displayLarge: AppTypography.h1.copyWith(color: colorScheme.onSurface),
        displayMedium: AppTypography.h2.copyWith(color: colorScheme.onSurface),
        displaySmall: AppTypography.h3.copyWith(color: colorScheme.onSurface),
        headlineLarge: AppTypography.h4.copyWith(color: colorScheme.onSurface),
        headlineMedium: AppTypography.h5.copyWith(color: colorScheme.onSurface),
        headlineSmall: AppTypography.h6.copyWith(color: colorScheme.onSurface),
        titleLarge: AppTypography.h5.copyWith(color: colorScheme.onSurface),
        titleMedium: AppTypography.h6.copyWith(color: colorScheme.onSurface),
        titleSmall: AppTypography.labelLarge.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        bodyLarge: AppTypography.bodyLarge.copyWith(
          color: colorScheme.onSurface,
        ),
        bodyMedium: AppTypography.bodyMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        bodySmall: AppTypography.bodySmall.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        labelLarge: AppTypography.labelLarge.copyWith(
          color: colorScheme.onSurface,
        ),
        labelMedium: AppTypography.labelMedium.copyWith(
          color: colorScheme.onSurface,
        ),
        labelSmall: AppTypography.labelSmall.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Scaffold Background
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
    );
  }

  /// Light theme using Material Design 3 color scheme
  static ThemeData get lightTheme => _buildTheme(lightColorScheme());

  /// Dark theme using Material Design 3 color scheme
  static ThemeData get darkTheme => _buildTheme(darkColorScheme());
}
