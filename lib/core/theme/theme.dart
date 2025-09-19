import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final _primaryColor = const Color.fromARGB(255, 0, 140, 255);

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Colors.grey[50],
  // cardColor: Colors.white,
  canvasColor: Colors.grey[300],
  cardColor: Colors.white,
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Colors.black,
  canvasColor: Colors.grey[900],
);

extension ThemeDataExtension on ThemeData {
  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  Color get cupertinoAlertColor => const Color(0xFFF82B10);
  Color get cupertinoActionColor => const Color(0xFF3478F7);
}
