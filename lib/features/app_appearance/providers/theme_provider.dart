// lib/core/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
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
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

// Provider to get the current theme mode
final themeModeProvider = themeProvider;

// Provider to get the current theme data based on theme mode
final themeDataProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeModeProvider);

  switch (themeMode) {
    case ThemeMode.light:
      return AppTheme.lightTheme;
    case ThemeMode.dark:
      return AppTheme.darkTheme;
    case ThemeMode.system:
      // Return light theme by default, system theme will be handled by MaterialApp
      return AppTheme.lightTheme;
  }
});
