import 'package:wallpaper_app/domains/wallpaper/data/datasources/remote/wallpaper_remote_datasource.dart';
import 'package:wallpaper_app/domains/wallpaper/data/mapper/wallpaper_mapper.dart';
import 'package:wallpaper_app/domains/wallpaper/data/repositories/wallpaper_repository_impl.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/repositories/wallpaper_repository.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/usecases/get_photos_usecase.dart';
import 'package:wallpaper_app/injections/injections.dart';

class WallpaperDependency {
  WallpaperDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<WallpaperRemoteDatasource>(
      () => WallpaperRemoteDatasourceImpl(
        dio: sl(),
      ),
    );
  }

  void _registerMapper() {
    sl.registerLazySingleton<WallpaperMapper>(
      () => WallpaperMapper(),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<WallpaperRepository>(() => WallpaperRepositoryImpl(
          wallpaperRemoteDatasource: sl(),
          wallpaperMapper: sl(),
        ));
  }

  void _registerUseCases() {
    sl.registerLazySingleton<GetPhotosUseCase>(
      () => GetPhotosUseCase(
        wallpaperRepository: sl(),
      ),
    );
  }
}
