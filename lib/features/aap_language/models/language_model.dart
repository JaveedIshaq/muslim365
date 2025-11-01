import 'package:flutter/material.dart';

class LanguageModel {
  final String languageTitle;
  final String flag;
  final String languageCode;
  final String countryCode;
  final Locale locale;
  LanguageModel({
    required this.languageTitle,
    required this.flag,
    required this.languageCode,
    required this.countryCode,
    required this.locale,
  });
}

List<LanguageModel> languages = [
  LanguageModel(
    languageTitle: "ENGLISH",
    flag: "🇺🇸",
    languageCode: "en",
    countryCode: "US",
    locale: const Locale('en', 'US'),
  ),
  LanguageModel(
    languageTitle: "Español",
    flag: "🇲🇽",
    languageCode: "es",
    countryCode: "MX",
    locale: const Locale('es', 'MX'),
  ),
  // LanguageModel(
  //   languageTitle: "French",
  //   flag: "🇫🇷",
  //   languageCode: "fr",
  //   countryCode: "IN",
  //   locale: const Locale('fr', 'FR'),
  // ),
  // LanguageModel(
  //   languageTitle: "Chinese",
  //   flag: "🇨🇳",
  //   languageCode: "zh",
  //   countryCode: "CN",
  //   locale: const Locale('zh', 'CN'),
  // ),
  // LanguageModel(
  //   languageTitle: "Afrikaans",
  //   flag: "🇿🇦",
  //   languageCode: "af",
  //   countryCode: "ZA",
  //   locale: const Locale('af', 'ZA'),
  // ),
  // LanguageModel(
  //   languageTitle: "Arabic",
  //   flag: "🇸🇦",
  //   languageCode: "ar",
  //   countryCode: "SA",
  //   locale: const Locale('ar', 'SA'),
  // ),
  // LanguageModel(
  //   languageTitle: "Deutsch",
  //   flag: "🇩🇪",
  //   languageCode: "de",
  //   countryCode: "DE",
  //   locale: const Locale('de', 'DE'),
  // ),
];

List<Locale> getLocalesFromLanguageModels() {
  return languages.map((language) => language.locale).toList();
}

String getFlagFromLanguageTitle(String languageTitle) {
  String flag = "";

  for (var language in languages) {
    if (language.languageTitle == languageTitle) {
      flag = language.flag;
    }
  }

  return flag;
}

List<String> getLanguageNamesFromLanguageModels() {
  return languages.map((language) => language.languageTitle).toList();
}
