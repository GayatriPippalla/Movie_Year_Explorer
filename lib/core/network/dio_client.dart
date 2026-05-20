import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class DioClient {

  late Dio dio;

  DioClient() {

    dio = Dio(

      BaseOptions(

        baseUrl: ApiConstants.baseUrl,

        connectTimeout:
        const Duration(seconds: 10),

        receiveTimeout:
        const Duration(seconds: 10),
      ),
    );

    // API KEY INTERCEPTOR
    dio.interceptors.add(

      InterceptorsWrapper(

        onRequest:
            (options, handler) {

          options.queryParameters.addAll({

            'apikey':
            ApiConstants.apiKey,
          });

          return handler.next(options);
        },
      ),
    );

    // LOGGING
    dio.interceptors.add(

      LogInterceptor(

        requestBody: true,

        responseBody: true,
      ),
    );
  }
}