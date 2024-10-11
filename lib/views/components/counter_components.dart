import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vibration/vibration.dart';

import 'package:counter_application/notifiers/settings_notifier.dart';
import 'package:counter_application/notifiers/count_notifier.dart';
import 'package:counter_application/notifiers/count_list_notifier.dart';

class CounterBody extends ConsumerWidget {
  const CounterBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countNotifier = ref.read(countProvider.notifier);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Vibration.vibrate(duration: 100);
        countNotifier.increment();
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
    );
  }
}

class CounterPanel extends ConsumerWidget {
  const CounterPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countProvider);
    final settings = ref.watch(settingsProvider).requireValue;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Text(
          '$count',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: (settings.changeColor) &&
                        (settings.colorChangeValue <= count)
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
    final count = ref.watch(countProvider);
    final countNotifier = ref.read(countProvider.notifier);
    final countListNotifier = ref.read(countListProvider.notifier);

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

              countListNotifier.addCount(count);
              countNotifier.reset();

              Navigator.of(context).pop();
            },
            child: const Text('はい')),
      ],
    );
  }
}
