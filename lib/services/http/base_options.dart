import 'dart:io';
import 'package:cocoexplorer_mobile/configs/network_config.dart';
import 'package:dio/dio.dart';

BaseOptions getBaseOptions() {
  return BaseOptions(
    headers: {
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
    },
    validateStatus: (statusCode) => statusCode != null && statusCode < 400,
    connectTimeout: NetworkConfig.connectTimeout,
    sendTimeout: NetworkConfig.sendTimeout,
    receiveTimeout: NetworkConfig.receiveTimeout,
  );
}

// This exception was thrown because the response has a status code of 502 and RequestOptions.validateStatus was configured to throw for this status code.
