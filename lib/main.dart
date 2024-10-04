import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/infrastructures/shared_preferences.dart';
import 'package:counter_application/infrastructures/sqlite.dart';

import 'package:counter_application/notifiers/settings_notifier.dart';

import 'package:counter_application/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      overrides: [
        prefsProvider.overrideWithValue(
          await getSharedPreferences(),
        ),
        dbProvider.overrideWithValue(
          await openAppDatabase(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: settings.themeColor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: settings.themeColor,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainPage(),
    );
  }
}
