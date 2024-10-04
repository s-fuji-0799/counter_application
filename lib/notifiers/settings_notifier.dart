import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/models/settings_model.dart';
import 'package:counter_application/repositories/settings_repository.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsModel>(
  () => SettingsNotifier(),
);

class SettingsNotifier extends Notifier<SettingsModel> {
  SettingsRepository get _repository => ref.watch(settingsRepositoryProvider);

  @override
  SettingsModel build() => _repository.getSettings();

  void setChangeColor(bool value) {
    state = state.copyWith(changeColor: value);
    _repository.setChangeColor(value);
  }

  void setColorChangeValue(int value) {
    state = state.copyWith(colorChangeValue: value);
    _repository.setColorChangeValue(value);
  }

  void setThemeColor(Color color) {
    state = state.copyWith(themeColor: color);
    _repository.setThemeColor(color);
  }
}
