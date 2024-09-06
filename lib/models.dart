class CounterModel {
  CounterModel();
  int _count = 0;

  // メソッド一覧
  void set(int value) {
    _count = value;
  }

  void increment() {
    _count++;
  }

  // ゲッター
  int get count => _count;
}

class CounterSettingsModel {
  CounterSettingsModel();
  bool _counterColorChanges = true;
  int _counterColorChangesValue = 70;

  // メソッド一覧
  void setCounterColorChanges(bool value) {
    _counterColorChanges = value;
  }

  void setCounterColorChangesValue(int value) {
    _counterColorChangesValue = value;
  }

  // ゲッター
  bool get counterColorChanges => _counterColorChanges;
  int get counterColorChangesValue => _counterColorChangesValue;
}
