import 'package:cocoexplorer_mobile/configs/endpoints.dart';
import 'package:cocoexplorer_mobile/models/caption_model.dart';
import 'package:cocoexplorer_mobile/models/image_model.dart';
import 'package:cocoexplorer_mobile/models/instance_model.dart';
import 'package:dio/dio.dart';

class CocoApiService {
  final Endpoints _endpoints;
  final Dio _client;

  CocoApiService(this._client, this._endpoints);

  Future<List<int>> getImageIds(List<int> tagIds) async {
    final payload = tagIds.map((e) => 'category_ids[]=$e').join('&');
    final response = await _client.post(
      _endpoints.dataset,
      data: '$payload&querytype=getImagesByCats',
    );

    final List<dynamic> rawList = response.data;
    return rawList.map((e) => e as int).toList();
  }

  Future<List<ImageModel>> getImages(List<int> imgIds) async {
    final payload = imgIds.map((e) => 'image_ids[]=$e').join('&');
    final response = await _client.post(
      _endpoints.dataset,
      data: '$payload&querytype=getImages',
    );
    return (response.data as List<dynamic>)
        .map((e) => ImageModel.fromJson(e))
        .toList();
  }

  Future<List<InstanceModel>> getInstances(List<int> imgIds) async {
    final payload = imgIds.map((e) => 'image_ids[]=$e').join('&');
    final response = await _client.post(
      _endpoints.dataset,
      data: '$payload&querytype=getInstances',
    );
    return (response.data as List<dynamic>)
        .map((e) => InstanceModel.fromJson(e))
        .toList();
  }

  Future<List<CaptionModel>> getCaptions(List<int> imgIds) async {
    final payload = imgIds.map((e) => 'image_ids[]=$e').join('&');
    final response = await _client.post(
      _endpoints.dataset,
      data: '$payload&querytype=getCaptions',
    );
    return (response.data as List<dynamic>)
        .map((e) => CaptionModel.fromJson(e))
        .toList();
  }
}
