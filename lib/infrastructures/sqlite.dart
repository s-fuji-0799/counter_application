import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sqflite/sqflite.dart';

import 'package:counter_application/repositories/count_repository.dart';

final dbProvider = Provider<Database>(
  (ref) => throw UnimplementedError(),
);

Future<Database> openAppDatabase() async => await openDatabase(
      'app.db',
      version: 1,
      onCreate: (db, version) async {
        await createCountTable(db);
      },
    );
