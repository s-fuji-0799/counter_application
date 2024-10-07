import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:counter_application/constants/settings_constants.dart';

final settingsPrefsProvider = Provider<SharedPreferencesWithCache>(
  (_) => throw UnimplementedError(),
);

Future<SharedPreferencesWithCache> getSharedPreferences() async {
  return await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: settingsSet,
    ),
  );
}
