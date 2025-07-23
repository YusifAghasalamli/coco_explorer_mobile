import 'package:cocoexplorer_mobile/utils/color_utils.dart';
import 'package:flutter/material.dart';

class AppColorScheme {
  // light color scheme
  static ColorScheme light = ColorScheme.fromSeed(
    seedColor: ColorUtils.random(),
    brightness: Brightness.light,
  );

  // dark color scheme
  static ColorScheme dark = ColorScheme.fromSeed(
    seedColor: ColorUtils.random(),
    brightness: Brightness.dark,
  );
}
