import 'dart:ui';

import 'package:cocoexplorer_mobile/constants/id_to_cat.dart';

class CocoModel {
  CocoModel({
    required this.captions,
    required this.cats,
    required this.imageId,
    required this.segmentations,
    required this.url,
  });

  final int imageId;
  final String url;
  final List<Segmentation> segmentations; // List<List<List>>
  final List<int> cats;
  final List<String> captions;

  List<String> get catNames =>
      cats.map((e) => idToCat[e]).whereType<String>().toList();
}

class Segmentation {
  Segmentation({
    required this.catId,
    required this.segmentations,
    required this.color,
  });

  final List<dynamic> segmentations; // List<List>
  final int catId;
  final Color color;
}
