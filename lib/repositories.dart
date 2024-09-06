import 'package:shared_preferences/shared_preferences.dart';

// DIできそうならしたい
class LastCountRepository {
  LastCountRepository();
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // メソッド一覧
  void set(int count) {
    _prefs.setInt('lastCount', count);
  }

  int? get() {
    return _prefs.getInt('lastCount');
  }
}

class CounterSettingsRepository {
  CounterSettingsRepository();
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // メソッド一覧
  void setCounterColorChanges(bool value) {
    _prefs.setBool('counterColorChanges', value);
  }

  bool? getCounterColorChanges() {
    return _prefs.getBool('counterColorChanges');
  }

  void setCounterColorChangesValue(int value) {
    _prefs.setInt('counterColorChangesValue', value);
  }

  int? getCounterColorChangesValue() {
    return _prefs.getInt('counterColorChangesValue');
  }
}
