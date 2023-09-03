import 'package:dio/dio.dart';
import 'package:wallpaper_app/shared_libraries/utils/constants/app_constants.dart';

import '../../../injections/injections.dart';
import '../../utils/setup/app_setup.dart';
import '../network/dio_handler.dart';

class RegisterCoreModule {
  Future<void> core() async {
    sl.registerLazySingleton<Dio>(() => sl<DioHandler>().dio);
    sl.registerLazySingleton<DioHandler>(
      () => DioHandler(
        token: AppConstants.appApi.token,
        apiBaseUrl: Config.baseUrl,
      ),
    );
  }
}
