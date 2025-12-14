import 'package:flutter/material.dart';

/// Brand-specific colors NOT covered by Material Theme Builder.
///
/// Use these only for dashboard-specific colors that don't exist in Material Design 3.
/// For all standard colors (primary, surface, onSurface, etc.), use Theme.of(context).colorScheme
class BrandColors {
  // Private constructor to prevent instantiation
  BrandColors._();

  // Dashboard-specific colors (from your professional dashboard design)

  /// Availability status colors
  static const Color availabilityAvailable = Color(0xFF10B981); // Green
  static const Color availabilityScheduled = Color(0xFF3B82F6); // Blue

  /// Shift status colors
  static const Color statusOpen = Color(0xFF10B981); // Green
  static const Color statusCompleted = Color(0xFF64748B); // Gray
  static const Color statusPending = Color(0xFFF59E0B); // Yellow

  /// Action button colors (from dashboard)
  static const Color buttonSetAvailability = Color(0xFF1E40AF); // Dark Blue
  static const Color buttonBrowseShifts = Color(0xFF10B981); // Green
  static const Color buttonMyShifts = Color(0xFF3B82F6); // Primary Blue
  static const Color buttonProfile = Color(0xFFF97316); // Orange
  static const Color buttonEarnings = Color(0xFF10B981); // Green

  /// Dashboard card backgrounds
  static const Color cardBgScheduledLight = Color(0xFFEFF6FF); // Blue-50
  static const Color cardBgAvailableLight = Color(0xFFECFDF5); // Green-50
  static const Color cardBgScheduledDark = Color(0xFF1E3A8A); // Blue-900/40
  static const Color cardBgAvailableDark = Color(0xFF064E3B); // Green-900/40

  /// Gradients (for specific components that need brand gradients)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xff445e91), Color(0xff445e91)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient earningsGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Semantic colors (supplementary to Material Theme)
  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFF59E0B); // Yellow/Orange
  static const Color info = Color(0xFF3B82F6); // Blue (same as primary)

  /// Rating and stats colors
  static const Color ratingStar = Color(0xFFF59E0B); // Yellow
  static const Color earnings = Color(0xFF10B981); // Green
  static const CurrencyColor currency = CurrencyColor();

  /// Utility colors
  static const Color transparent = Color(0x00000000);
  static const Color overlayDark = Color(0x40000000); // 25% black overlay
  static const Color divider = Color(0xFFE5E7EB);

  /// Get card background color based on theme and type
  static Color getCardBackground(
    BuildContext context, {
    required CardType type,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (type) {
      case CardType.scheduled:
        return isDark ? cardBgScheduledDark : cardBgScheduledLight;
      case CardType.available:
        return isDark ? cardBgAvailableDark : cardBgAvailableLight;
    }
  }

  /// Get text color for card content based on background
  static Color getCardTextColor(
    BuildContext context, {
    required CardType type,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (type) {
      case CardType.scheduled:
        return isDark ? Colors.white : availabilityScheduled;
      case CardType.available:
        return isDark ? Colors.white : availabilityAvailable;
    }
  }
}

/// Card types for dashboard cards
enum CardType { scheduled, available }

/// Currency-specific colors
class CurrencyColor {
  const CurrencyColor();

  Color get positive => BrandColors.earnings;
  Color get negative => const Color(0xFFEF4444); // Red
  Color get neutral => const Color(0xFF64748B); // Gray
}

/// Helper methods for brand colors
extension BrandColorHelpers on Color {
  /// Get with opacity
  Color withOpacity(double opacity) => withValues(alpha: opacity);

  /// Get lighter variant
  Color lighter({double amount = 0.1}) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Get darker variant
  Color darker({double amount = 0.1}) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }
}
