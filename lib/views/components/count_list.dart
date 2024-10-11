import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/models/count_model.dart';
import 'package:counter_application/notifiers/count_list_notifier.dart';

class CountListView extends ConsumerWidget {
  const CountListView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCountList = ref.watch(countListProvider);

    return switch (asyncCountList) {
      AsyncData(:final value) => (value.isNotEmpty)
          ? ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) =>
                  CountListTile(count: value[index]),
            )
          : const Center(child: Text('履歴がありません')),
      AsyncError(:final error) => Center(
          child: Text(error.toString()),
        ),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}

class CountListTile extends ConsumerWidget {
  const CountListTile({super.key, required this.count});

  final Count count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countListNotifier = ref.read(countListProvider.notifier);

    return ListTile(
      title: Text(count.value.toString()),
      subtitle: Text(count.countedAt.toString()),
      onLongPress: () => countListNotifier.deleteCount(count.id!),
    );
  }
}
