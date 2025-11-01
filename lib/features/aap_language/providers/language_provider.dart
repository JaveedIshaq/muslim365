import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/language_model.dart';

class LanguageNotifier extends Notifier<Locale> {
  static const String languageCodeKey = 'language_code';
  static const String countryCodeKey = 'country_code';

  @override
  Locale build() {
    _loadLanguage();
    return const Locale('en', 'US');
  }

  Future<void> setLanguage(Locale locale) async {
    state = locale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageCodeKey, locale.languageCode);
    await prefs.setString(countryCodeKey, locale.countryCode ?? '');
  }

  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(languageCodeKey);
    String? countryCode = prefs.getString(countryCodeKey);
    
    if (languageCode != null) {
      state = Locale(languageCode, countryCode);
    }
  }
}

// Provider for the language notifier
final languageProvider = NotifierProvider<LanguageNotifier, Locale>(LanguageNotifier.new);

// Provider to get the current language
final currentLanguageProvider = languageProvider;

// Provider to get the current language model
final currentLanguageModelProvider = Provider<LanguageModel?>((ref) {
  final currentLocale = ref.watch(currentLanguageProvider);
  
  try {
    return languages.firstWhere(
      (language) => language.locale == currentLocale,
    );
  } catch (e) {
    // Return English as default if not found
    return languages.firstWhere(
      (language) => language.languageCode == 'en',
    );
  }
});