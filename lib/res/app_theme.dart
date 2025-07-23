import 'package:cocoexplorer_mobile/res/app_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData getTheme({bool isDark = false}) {
  final colorScheme = isDark ? AppColorScheme.dark : AppColorScheme.light;

  return ThemeData.from(colorScheme: colorScheme, useMaterial3: true);
}
