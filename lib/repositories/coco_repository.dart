import 'package:cocoexplorer_mobile/models/caption_model.dart';
import 'package:cocoexplorer_mobile/models/image_model.dart';
import 'package:cocoexplorer_mobile/models/instance_model.dart';
import 'package:cocoexplorer_mobile/services/api/coco_api_service.dart';

class CocoRepository {
  CocoRepository(this._apiService);
  final CocoApiService _apiService;

  Future<List<int>> getImageIds(List<int> tagIds) =>
      _apiService.getImageIds(tagIds);

  Future<List<ImageModel>> getImages(List<int> imgIds) =>
      _apiService.getImages(imgIds);

  Future<List<InstanceModel>> getInstances(List<int> imgIds) =>
      _apiService.getInstances(imgIds);

  Future<List<CaptionModel>> getCaptions(List<int> imgIds) =>
      _apiService.getCaptions(imgIds);
}
