import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/models/settings_model.dart';
import 'package:counter_application/repositories/settings_repository.dart';

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, Settings>(
  () => SettingsNotifier(),
);

class SettingsNotifier extends AsyncNotifier<Settings> {
  SettingsRepository get _repository => ref.watch(settingsRepositoryProvider);

  @override
  Future<Settings> build() async => await _repository.getSettings();

  Future<void> setChangeColor(bool value) async {
    await _repository.setChangeColor(value);
    ref.invalidateSelf();
  }

  Future<void> setColorChangeValue(int value) async {
    await _repository.setColorChangeValue(value);
    ref.invalidateSelf();
  }

  Future<void> setThemeColor(Color color) async {
    await _repository.setThemeColor(color);
    ref.invalidateSelf();
  }
}
