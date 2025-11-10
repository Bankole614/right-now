// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _prefsKey = 'hisend_theme_mode';

/// StateNotifier that holds ThemeMode and persists changes to SharedPreferences.
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier(super.initial);

  /// Change theme and persist choice.
  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, _stringFor(mode));
    } catch (_) {
      // ignore persistence errors for now; you may log/report as needed
    }
  }

  static String _stringFor(ThemeMode m) {
    switch (m) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.system:
      return 'system';
    }
  }

  static ThemeMode _modeFromString(String? s) {
    switch (s) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Helper: load saved value from SharedPreferences
  static Future<ThemeMode> loadSavedMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final val = prefs.getString(_prefsKey);
      return _modeFromString(val);
    } catch (_) {
      return ThemeMode.system;
    }
  }
}

/// Provider (StateNotifierProvider) for ThemeNotifier.
/// We'll override the provider in main with a ThemeNotifier created with the saved initial value.
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  // default: system. main.dart should override with persisted value.
  return ThemeNotifier(ThemeMode.system);
});
