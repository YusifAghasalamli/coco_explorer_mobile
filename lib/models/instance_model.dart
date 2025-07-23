import 'package:cocoexplorer_mobile/utils/extensions/string_extension.dart';

class InstanceModel {
  InstanceModel({
    required this.catId,
    required this.imageId,
    required this.segmentation,
  });
  final int imageId;
  final List<dynamic> segmentation;
  final int catId;

  factory InstanceModel.fromJson(Map<String, dynamic> json) => InstanceModel(
    catId: json['category_id'],
    imageId: json['image_id'],
    segmentation: (json['segmentation'] as String).toIntPolygonList(),
  );
}
