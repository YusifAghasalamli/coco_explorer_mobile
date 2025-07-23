class Endpoints {
  const Endpoints();

  final _baseURl = "https://us-central1-open-images-dataset.cloudfunctions.net";

  @override
  String toString() => _baseURl;

  String get dataset => '$_baseURl/coco-dataset-bigquery';
}
