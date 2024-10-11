import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/infrastructures/sqlite.dart';

import 'package:counter_application/notifiers/settings_notifier.dart';

import 'package:counter_application/views/pages/main_page.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  widgetsBinding.deferFirstFrame();

  runApp(
    const ProviderScope(
      child: _EagerInitialization(child: MainApp()),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).requireValue;

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

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(_eagerInitializationProvider);

    // エラー状態とローディング状態を処理します。
    return result.when(
      data: (data) {
        if (!WidgetsBinding.instance.firstFrameRasterized) {
          WidgetsBinding.instance.allowFirstFrame();
        }

        return child;
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

final _eagerInitializationProvider = FutureProvider(
  (ref) async {
    await ref.read(dbProvider.future);
    await ref.read(settingsProvider.future);
  },
);
