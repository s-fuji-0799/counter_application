import 'package:flutter/material.dart';

import 'package:counter_application/models/settings_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:counter_application/infrastructures/shared_preferences.dart';
import 'package:counter_application/constants/settings_constants.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(prefsProvider)),
);

class SettingsRepository {
  const SettingsRepository(this._prefs);
  final SharedPreferences _prefs;

  SettingsModel getSettings() {
    return SettingsModel(
      changeColor: _prefs.getBool(changeColor) ?? true,
      colorChangeValue: _prefs.getInt(colorChangeValue) ?? 70,
      themeColor: Color(
        _prefs.getInt(themeColor) ?? Colors.purple.value,
      ),
    );
  }

  Future<bool> setChangeColor(bool value) async =>
      await _prefs.setBool(changeColor, value);

  Future<bool> setColorChangeValue(int value) async =>
      await _prefs.setInt(colorChangeValue, value);

  Future<bool> setThemeColor(Color color) async =>
      await _prefs.setInt(themeColor, color.value);
}
