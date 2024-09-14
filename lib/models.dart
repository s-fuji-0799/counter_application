class SettingsModel {
  const SettingsModel({
    required this.counterColorChanges,
    required this.counterColorChangesValue,
  });

  final bool counterColorChanges;
  final int counterColorChangesValue;

  SettingsModel copyWith(
      {bool? counterColorChanges, int? counterColorChangesValue}) {
    return SettingsModel(
      counterColorChanges: counterColorChanges ?? this.counterColorChanges,
      counterColorChangesValue:
          counterColorChangesValue ?? this.counterColorChangesValue,
    );
  }
}
