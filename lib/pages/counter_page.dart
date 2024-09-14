import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vibration/vibration.dart';

import 'package:counter_application/providers.dart';
import 'package:counter_application/components/counter_components.dart';
import 'package:counter_application/pages/settings_page.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Vibration.vibrate(duration: 100);
          ref.read(counterProvider.notifier).increment();
        },
        onLongPress: () {
          Vibration.vibrate(duration: 100);
          showDialog(
            context: context,
            builder: (_) => const CounterResetDialog(),
          );
        },
        child: const Center(
          child: CounterPanel(),
        ),
      ),
    );
  }
}
