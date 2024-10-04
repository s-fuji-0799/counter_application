import 'package:counter_application/infrastructures/sqlite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import 'package:counter_application/constants/count_constants.dart';
import 'package:counter_application/models/count_model.dart';

final countRepositoryProvider = Provider<CountRepository>(
  (ref) => CountRepository(ref.watch(dbProvider)),
);

Future<void> createCountTable(Database db) async {
  await db.execute(
    '''
    CREATE TABLE $tableCount (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnCountedAt INTEGER,
      $columnValue INTEGER
    )
    ''',
  );
}

class CountRepository {
  const CountRepository(this._db);
  final Database _db;

  Future<void> insertCount(Count count) async {
    await _db.insert(tableCount, count.toMap());
  }

  Future<void> deleteCount(int id) async {
    await _db.delete(tableCount, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Count>> getAllCount() async {
    final rawCountList = await _db.query(
      tableCount,
      columns: [columnId, columnCountedAt, columnValue],
      orderBy: '$columnCountedAt DESC',
    );

    if (rawCountList.isNotEmpty) {
      return rawCountList.map((e) => Count.fromMap(e)).toList();
    }
    return [];
  }
}
