import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/models/settings_model.dart';
import 'package:counter_application/repositories/settings_repository.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, Settings>(
  () => SettingsNotifier(),
);

class SettingsNotifier extends Notifier<Settings> {
  SettingsRepository get _repository => ref.watch(settingsRepositoryProvider);

  @override
  Settings build() => _repository.getSettings();

  Future<void> setChangeColor(bool value) async {
    await _repository.setChangeColor(value);
    ref.invalidateSelf();
  }

  Future<void> setColorChangeValue(int value) async {
    await _repository.setColorChangeValue(value);
  }

  Future<void> setThemeColor(Color color) async {
    await _repository.setThemeColor(color);
  }
}
