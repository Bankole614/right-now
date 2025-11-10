// lib/services/preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _kOnboardingDone = 'onboardingDone';

  /// Marks onboarding as completed.
  /// Returns true if operation succeeded.
  static Future<bool> setOnboardingDone({bool value = true}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.setBool(_kOnboardingDone, value);
    } catch (_) {
      return false;
    }
  }

  /// Returns true if onboarding has been completed before.
  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kOnboardingDone) ?? false;
  }

  /// Developer helper: reset the onboarding flag
  static Future<bool> resetOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.remove(_kOnboardingDone);
    } catch (_) {
      return false;
    }
  }
}
