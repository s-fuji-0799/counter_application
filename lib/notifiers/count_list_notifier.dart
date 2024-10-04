import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/repositories/count_repository.dart';
import 'package:counter_application/models/count_model.dart';

final countListProvider =
    AsyncNotifierProvider<CountList, List<Count>>(() => CountList());

class CountList extends AsyncNotifier<List<Count>> {
  CountRepository get _repository => ref.watch(countRepositoryProvider);

  Future<List<Count>> _fetchCountList() async {
    return await _repository.getAllCount();
  }

  @override
  FutureOr<List<Count>> build() async {
    return _fetchCountList();
  }

  Future<void> addCount(int value) async {
    state = await AsyncValue.guard(
      () async {
        await _repository.insertCount(
          Count(
            countedAt: DateTime.now(),
            value: value,
          ),
        );

        return _fetchCountList();
      },
    );
  }

  Future<void> deleteCount(int id) async {
    state = await AsyncValue.guard(() async {
      await _repository.deleteCount(id);

      return _fetchCountList();
    });
  }
}
