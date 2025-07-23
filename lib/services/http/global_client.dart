import 'package:cocoexplorer_mobile/services/http/base_options.dart';
import 'package:dio/dio.dart';

Dio getGlobalClient() {
  Dio globalClient = Dio(getBaseOptions())
    ..interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
    ]);

  return globalClient;
}
