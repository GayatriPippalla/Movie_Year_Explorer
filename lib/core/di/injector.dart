import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../config/app_config.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConfig.instance.baseUrl,
      ),
    ),
  );

}