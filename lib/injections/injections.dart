import 'package:get_it/get_it.dart';
import 'package:wallpaper_app/domains/wallpaper/di/dependency.dart';

import '../shared_libraries/core/di/core_module.dart';
import '../shared_libraries/utils/di/utils_module.dart';

final sl = GetIt.instance;

class Injections {
  Future<void> initialize() async {
    await _registerSharedLibraries();
    _registerDomains();
  }

  Future<void> _registerSharedLibraries() async {
    await RegisterCoreModule().core();
    RegisterUtilsModule();
  }

  void _registerDomains() {
    WallpaperDependency();
  }
}
