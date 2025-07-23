import 'dart:math';
import 'dart:ui';

class ColorUtils {
  static Color random({double opacity = 1}) {
    final Random random = Random();
    return Color.fromARGB(
      (opacity * 255).toInt(),
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
