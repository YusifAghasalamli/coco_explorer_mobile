class CaptionModel {
  CaptionModel({required this.caption, required this.imageId});

  final String caption;
  final int imageId;

  factory CaptionModel.fromJson(Map<String, dynamic> json) =>
      CaptionModel(caption: json['caption'], imageId: json['image_id']);
}
