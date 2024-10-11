import 'package:flutter/material.dart';

const String changeColor = 'changeColor';
const String colorChangeValue = 'colorChangeValue';
const String themeColor = 'themeColor';

class Settings {
  const Settings({
    required this.changeColor,
    required this.colorChangeValue,
    required this.themeColor,
  });

  final bool changeColor;
  final int colorChangeValue;
  final Color themeColor;

  Settings copyWith({
    bool? changeColor,
    int? colorChangeValue,
    Color? themeColor,
  }) {
    return Settings(
      changeColor: changeColor ?? this.changeColor,
      colorChangeValue: colorChangeValue ?? this.colorChangeValue,
      themeColor: themeColor ?? this.themeColor,
    );
  }
}
