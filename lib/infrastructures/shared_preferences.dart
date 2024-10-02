import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

final prefsProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError(),
);

Future<SharedPreferences> getSharedPreferences() async =>
    await SharedPreferences.getInstance();
