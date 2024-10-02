import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:counter_application/infrastructures/shared_preferences.dart';
import 'package:counter_application/constants/settings_constants.dart';
import 'package:counter_application/models/settings_model.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsModel>(
  () => SettingsNotifier(),
);

class SettingsNotifier extends Notifier<SettingsModel> {
  //TODO: prefsもrepository化する？
  SharedPreferences get _pref => ref.watch(prefsProvider);

  @override
  SettingsModel build() {
    return SettingsModel(
      changeColor: _pref.getBool(changeColor) ?? true,
      colorChangeValue: _pref.getInt(colorChangeValue) ?? 70,
      themeColor: Color(
        _pref.getInt(themeColor) ?? Colors.purple.value,
      ),
    );
  }

  void setCounterColorChanges(bool value) {
    state = state.copyWith(
      changeColor: value,
    );
    _pref.setBool(
      changeColor,
      state.changeColor,
    );
  }

  void setCounterColorChangesValue(int value) {
    state = state.copyWith(
      colorChangeValue: value,
    );
    _pref.setInt(
      colorChangeValue,
      state.colorChangeValue,
    );
  }

  void setThemeColor(Color color) {
    state = state.copyWith(
      themeColor: color,
    );
    _pref.setInt(
      themeColor,
      state.themeColor.value,
    );
  }
}
