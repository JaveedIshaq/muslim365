import 'package:flutter/material.dart';
import '../constants/theme_constants.dart';

/// A model representing a theme option with its properties
class ThemeOption {
  final ThemeMode mode;
  final String title;
  final String description;
  final IconData icon;
  final Color previewColor;

  const ThemeOption({
    required this.mode,
    required this.title,
    required this.description,
    required this.icon,
    required this.previewColor,
  });

  /// Creates a copy of this ThemeOption with updated values
  ThemeOption copyWith({
    ThemeMode? mode,
    String? title,
    String? description,
    IconData? icon,
    Color? previewColor,
  }) {
    return ThemeOption(
      mode: mode ?? this.mode,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      previewColor: previewColor ?? this.previewColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeOption &&
        other.mode == mode &&
        other.title == title &&
        other.description == description &&
        other.icon == icon &&
        other.previewColor == previewColor;
  }

  @override
  int get hashCode {
    return mode.hashCode ^
        title.hashCode ^
        description.hashCode ^
        icon.hashCode ^
        previewColor.hashCode;
  }

  @override
  String toString() {
    return 'ThemeOption(mode: $mode, title: $title, description: $description)';
  }
}

/// Extension to provide predefined theme options
extension ThemeOptions on ThemeOption {
  /// Returns all available theme options
  static List<ThemeOption> get all => [
        ThemeOption(
          mode: ThemeMode.light,
          title: ThemeConstants.lightThemeTitle,
          description: ThemeConstants.lightThemeDescription,
          icon: Icons.light_mode,
          previewColor: ThemeConstants.lightPreviewColor,
        ),
        ThemeOption(
          mode: ThemeMode.dark,
          title: ThemeConstants.darkThemeTitle,
          description: ThemeConstants.darkThemeDescription,
          icon: Icons.dark_mode,
          previewColor: ThemeConstants.darkPreviewColor,
        ),
        ThemeOption(
          mode: ThemeMode.system,
          title: ThemeConstants.systemThemeTitle,
          description: ThemeConstants.systemThemeDescription,
          icon: Icons.settings_system_daydream,
          previewColor: ThemeConstants.systemPreviewColor,
        ),
      ];

  /// Returns the display name for a ThemeMode
  static String getDisplayName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return ThemeConstants.lightThemeTitle;
      case ThemeMode.dark:
        return ThemeConstants.darkThemeTitle;
      case ThemeMode.system:
        return ThemeConstants.systemThemeTitle;
    }
  }

  /// Determines the appropriate icon color based on theme mode
  Color getIconColor() {
    switch (mode) {
      case ThemeMode.light:
        return Colors.black.withValues(alpha: ThemeConstants.lightIconOpacity);
      case ThemeMode.dark:
      case ThemeMode.system:
        return Colors.white.withValues(alpha: ThemeConstants.darkIconOpacity);
    }
  }
}