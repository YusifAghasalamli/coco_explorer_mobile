import 'package:cocoexplorer_mobile/configs/endpoints.dart';
import 'package:cocoexplorer_mobile/locator/get_locator.dart';
import 'package:cocoexplorer_mobile/repositories/coco_repository.dart';
import 'package:cocoexplorer_mobile/services/api/coco_api_service.dart';
import 'package:cocoexplorer_mobile/services/http/global_client.dart';
import 'package:dio/dio.dart';

Future<void> setupLocator() async {
  locator.registerLazySingleton<Endpoints>(() => Endpoints());

  //// Services ////

  // HTTP service
  locator.registerLazySingleton<Dio>(() => getGlobalClient());

  // API services
  locator.registerLazySingleton<CocoApiService>(
    () => CocoApiService(locator.get(), locator.get()),
  );

  // // Repos
  locator.registerLazySingleton<CocoRepository>(
    () => CocoRepository(locator.get()),
  );
}
