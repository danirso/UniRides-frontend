import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient() : _dio = Dio(
    BaseOptions(
      baseUrl: 'https://unirides-backend-amfccyfebaapcggu.brazilsouth-01.azurewebsites.net',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Dio get instance => _dio;
}