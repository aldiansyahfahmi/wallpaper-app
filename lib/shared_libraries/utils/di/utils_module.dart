import 'package:wallpaper_app/shared_libraries/utils/navigation/router/home_router.dart';

import '../../../injections/injections.dart';
import '../navigation/navigation_helper.dart';

class RegisterUtilsModule {
  RegisterUtilsModule() {
    _navigations();
    _routers();
  }

  void _navigations() => sl.registerLazySingleton<NavigationHelper>(
        () => NavigationHelperImpl(),
      );

  void _routers() {
    sl.registerLazySingleton<HomeRouter>(
      () => HomeRouterImpl(
        navigationHelper: sl(),
      ),
    );
  }
}
