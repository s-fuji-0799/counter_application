const String tableCount = 'count';
const String columnId = 'id';
const String columnCountedAt = 'countedAt';
const String columnValue = 'value';

class Count {
  const Count({
    required this.id,
    required this.countedAt,
    required this.value,
  });

  final int id;
  final DateTime countedAt;
  final int value;

  Map<String, dynamic> toMap() => {
        columnId: id,
        columnCountedAt: countedAt.millisecondsSinceEpoch,
        columnValue: value,
      };

  factory Count.fromMap(Map<String, dynamic> map) => Count(
        id: map[columnId] as int,
        countedAt: DateTime.fromMillisecondsSinceEpoch(
          map[columnCountedAt] as int,
        ),
        value: map[columnValue] as int,
      );
}
