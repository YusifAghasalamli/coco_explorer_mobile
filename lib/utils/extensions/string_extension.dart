import 'dart:convert';

extension StringExtension on String {
  List<List<double>> toIntPolygonList() {
    try {
      final dynamic decoded = jsonDecode(this);
      if (decoded is List &&
          decoded.isNotEmpty &&
          decoded.first is List &&
          decoded.first.every((e) => e is num)) {
        return decoded
            .map<List<double>>(
              (inner) => (inner as List).map((e) => (e as double)).toList(),
            )
            .toList();
      }
    } catch (_) {}

    return [];
  }
}
