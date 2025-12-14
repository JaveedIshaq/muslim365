// App Appearance - Unified Export
//
// This file provides a single import point for all appearance-related constants
// and utilities in the NurseLife app.
//
// Usage:
// ```dart
// import 'package:mobile/features/app_appearance/app_appearance.dart';
//
//  Now you have access to:
// AppDimensions.spaceMD
// AppTypography.h3
// BrandColors.statusOpen
// Theme.of(context).colorScheme.primary
// ```

// ===== CONSTANTS =====
export 'constants/app_dimensions.dart';
export 'constants/app_typography.dart';
export 'constants/brand_colors.dart';
export 'constants/theme_constants.dart';

// ===== THEME =====
export 'theme/theme.dart';

// ===== UTILITIES =====
export 'util/util.dart';

// ===== PROVIDERS =====
export 'providers/theme_provider.dart';

// ===== MODELS =====
export 'models/theme_option.dart';
