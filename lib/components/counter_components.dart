import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vibration/vibration.dart';

import 'package:counter_application/providers.dart';

class CounterPanel extends ConsumerWidget {
  const CounterPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int count = ref.watch(counterProvider);
    final bool colorChanges = ref.watch(settingsProvider).counterColorChanges;
    final int colorChangesValue =
        ref.watch(settingsProvider).counterColorChangesValue;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Text(
          '$count',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: (colorChanges) && (colorChangesValue <= count)
                    ? Colors.red
                    : Theme.of(context).textTheme.displayLarge!.color,
              ),
        ),
      ),
    );
  }
}

class CounterResetDialog extends ConsumerWidget {
  const CounterResetDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('カウンターリセット'),
      content: const Text('カウンターをリセットしますか？'),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Vibration.vibrate(duration: 10);
              Navigator.of(context).pop();
            },
            child: const Text('いいえ')),
        TextButton(
            onPressed: () {
              Vibration.vibrate(duration: 10);
              ref.read(counterProvider.notifier).reset();
              Navigator.of(context).pop();
            },
            child: const Text('はい')),
      ],
    );
  }
}
