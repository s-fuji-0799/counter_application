import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import 'package:counter_application/providers.dart';

class CounterPanel extends StatelessWidget {
  const CounterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final int count = context.watch<CounterProvider>().count;
    final bool colorChanges =
        context.watch<CounterSettingsProvider>().counterColorChanges;
    final int colorChangesValue =
        context.watch<CounterSettingsProvider>().counterColorChangesValue;

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

class CounterResetDialog extends StatelessWidget {
  const CounterResetDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
              context.read<CounterProvider>().reset();
              Navigator.of(context).pop();
            },
            child: const Text('はい')),
      ],
    );
  }
}
