import 'package:counter_application/constants/count_constants.dart';

class Count {
  const Count({
    this.id,
    required this.countedAt,
    required this.value,
  });

  final int? id;
  final DateTime countedAt;
  final int value;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnCountedAt: countedAt.millisecondsSinceEpoch,
      columnValue: value,
    };

    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }

  factory Count.fromMap(Map<String, dynamic> map) => Count(
        id: map[columnId] as int,
        countedAt:
            DateTime.fromMillisecondsSinceEpoch(map[columnCountedAt] as int),
        value: map[columnValue],
      );
}
