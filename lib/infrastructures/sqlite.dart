import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

final dbProvider = FutureProvider<Database>(
  (ref) async => await openDatabase(
    'app.db',
    version: 1,
  ),
);
