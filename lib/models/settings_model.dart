import 'package:flutter/material.dart';

class SettingsModel {
  const SettingsModel({
    required this.changeColor,
    required this.colorChangeValue,
    required this.themeColor,
  });

  final bool changeColor;
  final int colorChangeValue;
  final Color themeColor;

  SettingsModel copyWith({
    bool? changeColor,
    int? colorChangeValue,
    Color? themeColor,
  }) {
    return SettingsModel(
      changeColor: changeColor ?? this.changeColor,
      colorChangeValue: colorChangeValue ?? this.colorChangeValue,
      themeColor: themeColor ?? this.themeColor,
    );
  }
}
