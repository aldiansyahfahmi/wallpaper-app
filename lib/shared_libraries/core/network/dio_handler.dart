import 'package:dio/dio.dart';
import 'api_interceptors.dart';

class DioHandler {
  final String apiBaseUrl;
  final String token;

  DioHandler({
    required this.apiBaseUrl,
    required this.token,
  });

  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 30),
    );
    final dio = Dio(options);
    dio.interceptors.add(ApiInterceptors(token: token));

    return dio;
  }
}
