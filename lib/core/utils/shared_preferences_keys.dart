import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeys {
  Future _setStringData({required String key, required String text}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }

  Future setIntData({required String key, required int id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, id);
  }

  Future setBoolData({required String key, required bool text}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, text);
  }

  Future<String?> getStringData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<int?> getIntData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<bool?> getBoolData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future setLanguageType(Locale language) async {
    await _setStringData(key: 'language_code', text: language.languageCode);
    if (language.countryCode != null) {
      await _setStringData(key: 'country_code', text: language.countryCode!);
    }
  }

  Future<Locale> getLanguageType() async {
    String? languageCode = await getStringData(key: 'language_code');
    String? countryCode = await getStringData(key: 'country_code');
    return Locale(languageCode ?? "en", countryCode ?? "US");
  }
}
