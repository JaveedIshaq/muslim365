// lib/features/app_appearance/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  static const String themeModeKey = 'theme_mode';

  @override
  ThemeMode build() {
    _loadThemeMode();
    return ThemeMode.light;
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeModeKey, themeMode.index);
  }

  Future<void> _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? index = prefs.getInt(themeModeKey);
    if (index != null && index >= 0 && index <= 2) {
      state = ThemeMode.values[index];
    }
  }
}

// Provider for the theme notifier
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

// Provider to get the current theme mode
final themeModeProvider = themeProvider;

// Note: themeDataProvider is not needed since main.dart handles theme creation
// The theme is created in main.dart using createTextTheme and MaterialTheme
// This provider only manages the theme mode (light/dark/system)
