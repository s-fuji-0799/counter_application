import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = NotifierProvider<CountNotifier, int>(
  () => CountNotifier(),
);

class CountNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
  void reset() => state = 0;
}
