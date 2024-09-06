import 'package:flutter/material.dart';

import 'package:counter_application/models.dart';
import 'package:counter_application/repositories.dart';

// プロバイダーはMVVMのVMのような役割
class CounterProvider with ChangeNotifier {
  CounterProvider() {
    _init();
  }
  final LastCountRepository _repository = LastCountRepository();
  final CounterModel _model = CounterModel();

  Future<void> _init() async {
    await _repository.init();

    int? lastCount = _repository.get();

    if (lastCount != null) {
      _model.set(lastCount);
    }

    notifyListeners();
  }

  // メソッド一覧
  void increment() {
    _model.increment();
    _repository.set(_model.count);
    notifyListeners();
  }

  void reset() {
    _model.set(0);
    _repository.set(0);
    notifyListeners();
  }

  // ゲッター
  int get count => _model.count;
}

class CounterSettingsProvider with ChangeNotifier {
  CounterSettingsProvider() {
    _init();
  }
  final CounterSettingsRepository _repository = CounterSettingsRepository();
  final CounterSettingsModel _model = CounterSettingsModel();

  Future<void> _init() async {
    await _repository.init();

    bool? counterColorChanges = _repository.getCounterColorChanges();
    int? counterColorChangesValue = _repository.getCounterColorChangesValue();

    if (counterColorChanges != null) {
      _model.setCounterColorChanges(counterColorChanges);
    }
    if (counterColorChangesValue != null) {
      _model.setCounterColorChangesValue(counterColorChangesValue);
    }

    notifyListeners();
  }

  // メソッド一覧
  void setCounterColorChanges(bool value) {
    _model.setCounterColorChanges(value);
    _repository.setCounterColorChanges(value);
    notifyListeners();
  }

  void setCounterColorChangesValue(int value) {
    _model.setCounterColorChangesValue(value);
    _repository.setCounterColorChangesValue(value);
    notifyListeners();
  }

  // ゲッター
  bool get counterColorChanges => _model.counterColorChanges;
  int get counterColorChangesValue => _model.counterColorChangesValue;
}
