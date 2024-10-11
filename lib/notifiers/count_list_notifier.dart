import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:counter_application/repositories/count_repository.dart';
import 'package:counter_application/models/count_model.dart';

final countListProvider =
    AsyncNotifierProvider<CountList, List<Count>>(() => CountList());

class CountList extends AsyncNotifier<List<Count>> {
  CountRepository get _repository =>
      ref.watch(countRepositoryProvider).requireValue;

  @override
  FutureOr<List<Count>> build() async {
    return await _repository.getAllCount();
  }

  Future<void> addCount(int value) async {
    await _repository.insertCount(value);
    ref.invalidateSelf();
  }

  Future<void> deleteCount(int id) async {
    await _repository.deleteCount(id);
    ref.invalidateSelf();
  }
}
