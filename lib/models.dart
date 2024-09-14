import 'package:flutter/material.dart';

class SettingsModel {
  const SettingsModel({
    required this.counterColorChanges,
    required this.counterColorChangesValue,
    required this.themeColor,
  });

  final bool counterColorChanges;
  final int counterColorChangesValue;
  final Color themeColor;

  SettingsModel copyWith({
    bool? counterColorChanges,
    int? counterColorChangesValue,
    Color? themeColor,
  }) {
    return SettingsModel(
      counterColorChanges: counterColorChanges ?? this.counterColorChanges,
      counterColorChangesValue:
          counterColorChangesValue ?? this.counterColorChangesValue,
      themeColor: themeColor ?? this.themeColor,
    );
  }
}
