class ImageModel {
  ImageModel({required this.id, required this.flickUrl, required this.url});
  final int id;
  final String url;
  final String flickUrl; // in js code, this is the main url

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: json['id'],
    flickUrl: json['flickr_url'],
    url: json['coco_url'],
  );
}
