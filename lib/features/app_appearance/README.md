# App Appearance Feature

A reusable Flutter package for managing app appearance with theme selection. This package provides a complete theme management solution with Material Design 3 compliant themes.

## Features

- 🎨 **Theme Selection**: Light, Dark, and System theme options
- 📱 **Material Design 3**: Complete M3 compliant theming
- ✨ **Smooth Animations**: Animated theme selection UI with flutter_animate
- 💾 **Persistent Preferences**: Theme settings saved with shared_preferences
- 🏗️ **Riverpod Integration**: Built with flutter_riverpod for state management
- 🎯 **Easy Integration**: Simple setup with minimal configuration

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  flutter_animate: ^4.5.2
  google_fonts: ^6.3.2
  shared_preferences: ^2.5.3
```

## Setup

### 1. Copy the Package

Copy the entire `app_appearance` folder to your project's `lib/features/` directory.

### 2. Update Your Main App

Wrap your app with `ProviderScope` and configure the theme:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_app/features/app_appearance/app_appearance.dart'; // Update path

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    
    return MaterialApp(
      title: 'Your App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const YourHomePage(),
    );
  }
}
```

### 3. Add the Appearance Screen

Navigate to the appearance screen or add it to your settings:

```dart
import 'package:your_app/features/app_appearance/app_appearance.dart'; // Update path

// Navigate to appearance screen
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const AppAppearanceScreen(),
  ),
);
```

Or show just the theme selection bottom sheet:

```dart
import 'package:your_app/features/app_appearance/app_appearance.dart'; // Update path

// Show theme selection bottom sheet
await ThemeSelectionBottomSheet.show(context);
```

## Usage Examples

### Basic Theme Selection

```dart
import 'package:your_app/features/app_appearance/app_appearance.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Appearance'),
          subtitle: Text('Theme, language, and display options'),
          leading: Icon(Icons.palette),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AppAppearanceScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
```

### Custom Theme Button

```dart
import 'package:your_app/features/app_appearance/app_appearance.dart';

class ThemeButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    
    return IconButton(
      icon: Icon(_getThemeIcon(themeMode)),
      onPressed: () => ThemeSelectionBottomSheet.show(context),
    );
  }
  
  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_system_daydream;
    }
  }
}
```

## Customization

### Custom Colors

You can customize the theme colors by modifying the `AppTheme` class:

```dart
// In theme/app_theme.dart
static ColorScheme lightColorScheme() {
  return const ColorScheme(
    // Customize your colors here
    primary: Color(0xff6b38d4),
    // ... other colors
  );
}
```

### Custom Typography

Modify the typography in `constants/app_typography.dart`:

```dart
class AppTypography {
  static TextStyle get h1 => GoogleFonts.yourFont(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    // ... other properties
  );
  // ... other text styles
}
```

### Custom Dimensions

Update dimensions in `constants/app_dimensions.dart`:

```dart
class AppDimensions {
  static const double spaceMD = 16.0; // Adjust as needed
  // ... other dimensions
}
```

## Architecture

The package follows a clean architecture pattern:

```
lib/features/app_appearance/
├── constants/          # Constants for dimensions, typography, and theme
├── extensions/         # Widget animation extensions
├── models/            # Theme option models
├── providers/         # Riverpod state management
├── theme/             # Theme definitions
├── widgets/           # Reusable UI components
├── app_appearance_screen.dart  # Main appearance screen
├── app_appearance.dart         # Export file
└── README.md          # This file
```

## Dependencies

- `flutter_riverpod`: State management
- `flutter_animate`: Animations
- `google_fonts`: Typography
- `shared_preferences`: Persistent storage

## Contributing

Feel free to customize this package for your specific needs. The modular structure makes it easy to:

- Add new theme options
- Customize animations
- Modify the UI components
- Extend functionality

## License

This package is part of your project and follows the same license terms.