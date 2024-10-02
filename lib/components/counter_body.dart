import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vibration/vibration.dart';

import 'package:counter_application/notifiers/count_notifier.dart';
import 'package:counter_application/components/counter_components.dart';

class CounterBody extends ConsumerWidget {
  const CounterBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countNotifier = ref.watch(countProvider.notifier);

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
