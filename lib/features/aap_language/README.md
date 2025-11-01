# Language Selection Feature

This feature allows users to select their preferred language from a list of available languages. The selection is persisted using SharedPreferences and applied throughout the app.

## Files Structure

```
lib/features/aap_language/
├── models/
│   └── language_model.dart          # Language data model and list of available languages
├── providers/
│   └── language_provider.dart       # Riverpod provider for language state management
├── constants/
│   └── language_constants.dart       # Constants for UI strings and animation values
├── widgets/
│   ├── language_selection_bottom_sheet.dart  # Main bottom sheet widget
│   └── language_option_item.dart     # Individual language option widget
└── README.md                         # This file
```

## Usage

### Showing the Language Selection Bottom Sheet

```dart
import 'package:mobile/features/aap_language/widgets/language_selection_bottom_sheet.dart';

// Show the language selection bottom sheet
await LanguageSelectionBottomSheet.show(context);
```

### Watching the Current Language

```dart
import 'package:mobile/features/aap_language/providers/language_provider.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLanguageProvider);
    final currentLanguageModel = ref.watch(currentLanguageModelProvider);
    
    return Text('Current language: ${currentLanguageModel?.languageTitle}');
  }
}
```

### Changing the Language Programmatically

```dart
import 'package:mobile/features/aap_language/providers/language_provider.dart';
import 'package:mobile/features/aap_language/models/language_model.dart';

// Change to Spanish
ref.read(languageProvider.notifier).setLanguage(const Locale('es', 'MX'));

// Or using a language model
ref.read(languageProvider.notifier).setLanguage(languages[1]);
```

## Available Languages

Currently, the following languages are supported:

1. **English** (en-US) - 🇺🇸
2. **Español** (es-MX) - 🇲🇽

Additional languages can be added by updating the `languages` list in `language_model.dart`.

## Integration with Main App

The language provider is already integrated in `main.dart`:

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final themeMode = ref.watch(themeModeProvider);
  final currentLocale = ref.watch(currentLanguageProvider);  // Added this line
  return MaterialApp.router(
    // ... other configurations
    locale: currentLocale,  // Added this line
    // ... rest of the configuration
  );
}
```

## Features

- **Persistent Selection**: Language choice is saved and restored across app restarts
- **Animated UI**: Smooth animations for bottom sheet entrance and option selection
- **Visual Feedback**: Confirmation snackbar when language is changed
- **Flag Display**: Each language shows its country flag emoji
- **Responsive Design**: Works well on different screen sizes

## Dependencies

- `flutter_riverpod` for state management
- `shared_preferences` for persistence
- `flutter_animate` for animations