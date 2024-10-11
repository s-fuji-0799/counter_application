import 'package:flutter/material.dart';

import 'package:counter_application/models/settings_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:counter_application/infrastructures/shared_preferences.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(prefsProvider)),
);

class SettingsRepository {
  const SettingsRepository(this._prefs);
  final SharedPreferencesAsync _prefs;

  Future<Settings> getSettings() async {
    return Settings(
      changeColor: await _prefs.getBool(changeColor) ?? true,
      colorChangeValue: await _prefs.getInt(colorChangeValue) ?? 70,
      themeColor: Color(
        await _prefs.getInt(themeColor) ?? Colors.purple.value,
      ),
    );
  }

  Future<void> setChangeColor(bool value) async =>
      await _prefs.setBool(changeColor, value);

  Future<void> setColorChangeValue(int value) async =>
      await _prefs.setInt(colorChangeValue, value);

  Future<void> setThemeColor(Color color) async =>
      await _prefs.setInt(themeColor, color.value);
}
