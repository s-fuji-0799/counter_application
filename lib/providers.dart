import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:counter_application/models.dart';

class CounterNotifier extends Notifier<int> {
  @override
  int build() {
    return ref.read(prefsProvider).getInt('lastCount') ?? 0;
  }

  void increment() {
    state++;
    ref.read(prefsProvider).setInt('lastCount', state);
  }

  void reset() {
    state = 0;
    ref.read(prefsProvider).setInt('lastCount', 0);
  }
}

class SettingsNotifier extends Notifier<SettingsModel> {
  @override
  SettingsModel build() {
    return SettingsModel(
      counterColorChanges:
          ref.read(prefsProvider).getBool('counterColorChanges') ?? true,
      counterColorChangesValue:
          ref.read(prefsProvider).getInt('counterColorChangesValue') ?? 70,
      themeColor: Color(
        ref.read(prefsProvider).getInt('themeColor') ?? Colors.purple.value,
      ),
    );
  }

  void setCounterColorChanges(bool value) {
    state = state.copyWith(
      counterColorChanges: value,
    );
    ref.read(prefsProvider).setBool(
          'counterColorChanges',
          state.counterColorChanges,
        );
  }

  void setCounterColorChangesValue(int value) {
    state = state.copyWith(
      counterColorChangesValue: value,
    );
    ref.read(prefsProvider).setInt(
          'counterColorChangesValue',
          state.counterColorChangesValue,
        );
  }

  void setThemeColor(Color color) {
    state = state.copyWith(
      themeColor: color,
    );
    ref.read(prefsProvider).setInt(
          'themeColor',
          state.themeColor.value,
        );
  }
}

final counterProvider = NotifierProvider<CounterNotifier, int>(
  () => CounterNotifier(),
);

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsModel>(
  () => SettingsNotifier(),
);

final prefsProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError(),
);
