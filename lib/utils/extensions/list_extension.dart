import 'dart:math';

extension ListExtension<T> on List<T> {
  List<T> takeRandomAndRemove(int count) {
    if (count >= length) {
      final temp = toList();
      clear();
      return temp;
    }

    final random = Random();

    for (int i = 0; i < count; i++) {
      int j = i + random.nextInt(length - i);
      final temp = this[i];
      this[i] = this[j];
      this[j] = temp;
    }

    final picked = sublist(0, count);
    removeRange(0, count);
    return picked;
  }

  List<T> takeRandom(int count) {
    if (count >= length) return toList();

    final random = Random();
    final copy = toList();
    final result = <T>[];

    for (int i = 0; i < count; i++) {
      final index = random.nextInt(copy.length);
      result.add(copy.removeAt(index));
    }

    return result;
  }
}
