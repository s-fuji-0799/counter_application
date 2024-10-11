import 'package:counter_application/infrastructures/sqlite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import 'package:counter_application/models/count_model.dart';

final countRepositoryProvider = FutureProvider<CountRepository>(
  (ref) async {
    final db = await ref.watch(dbProvider.future);

    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS $tableCount (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnCountedAt INTEGER,
        $columnValue INTEGER
      )
      ''',
    );

    return CountRepository(db);
  },
);

class CountRepository {
  const CountRepository(this._db);
  final Database _db;

  Future<List<Count>> getAllCount() async {
    final list = await _db.query(
      tableCount,
      orderBy: '$columnCountedAt DESC',
    );

    if (list.isEmpty) {
      return [];
    } else {
      return list.map((e) => Count.fromMap(e)).toList();
    }
  }

  Future<void> insertCount(int value) async {
    final map = {
      columnCountedAt: DateTime.now().millisecondsSinceEpoch,
      columnValue: value,
    };

    await _db.insert(
      tableCount,
      map,
    );
  }

  Future<void> deleteCount(int id) async {
    await _db.delete(
      tableCount,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
