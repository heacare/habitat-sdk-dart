import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show ThemeMode;
import 'package:intl/locale.dart' as intl show Locale;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

// When we're ready, we can extend Preferences to include cloud syncing of
// these preferences using platform-specific features. See
// https://developer.apple.com/documentation/foundation/nsubiquitouskeyvaluestore
// https://developer.android.com/training/sync-adapters/

abstract class Preferences extends ChangeNotifier {
  ThemeMode get themeMode;
  Future<void> setThemeMode(final ThemeMode themeMode);

  bool get forceRTL;
  Future<void> setForceRTL(final bool rtl);

  Locale? get locale;
  Future<void> setLocale(final Locale? locale);
}

class AppPreferences extends Preferences {
  AppPreferences._(this._instance);

  final SharedPreferences _instance;

  static Future<Preferences> load() async {
    final AppPreferences preferences =
        AppPreferences._(await SharedPreferences.getInstance());
    // PlatformDispatcher.instance.onLocaleChanged = preferences.onLocaleChanged;
    return preferences;
  }

  @override
  ThemeMode get themeMode {
    final String? themeMode = _getString('themeMode');
    return ThemeMode.values.firstWhere(
      (final ThemeMode m) => m.name == themeMode,
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Future<void> setThemeMode(final ThemeMode themeMode) async {
    await _setString('themeMode', themeMode.name);
  }

  @override
  bool get forceRTL => _getBool('forceRTL') ?? false;

  @override
  Future<void> setForceRTL(final bool rtl) async {
    await _setBool('forceRTL', rtl);
  }

  @override
  Locale? get locale {
    final String? locale = _getString('locale');
    if (locale == null) {
      return null;
    }
    final intl.Locale parsed = intl.Locale.parse(locale);
    return Locale.fromSubtags(
      languageCode: parsed.languageCode,
      scriptCode: parsed.scriptCode,
      countryCode: parsed.countryCode,
    );
  }

  @override
  Future<void> setLocale(final Locale? locale) async {
    if (locale == null) {
      await _remove('locale');
      return;
    }
    await _setString('locale', locale.toLanguageTag());
  }

  Future<void> _remove(final String key) async {
    await _instance.remove(key);
    notifyListeners();
  }

  Future<void> _setString(final String key, final String value) async {
    await _instance.setString(key, value);
    notifyListeners();
  }

  String? _getString(final String key) => _instance.getString(key);

  Future<void> _setInt(final String key, final int value) async {
    await _instance.setInt(key, value);
    notifyListeners();
  }

  int? _getInt(final String key) => _instance.getInt(key);

  Future<void> _setBool(final String key, final bool value) async {
    await _instance.setBool(key, value);
    notifyListeners();
  }

  bool? _getBool(final String key) => _instance.getBool(key);
}
