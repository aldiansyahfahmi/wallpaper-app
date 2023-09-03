import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper_app/domains/wallpaper/data/datasources/remote/wallpaper_remote_datasource.dart';
import 'package:wallpaper_app/domains/wallpaper/data/mapper/wallpaper_mapper.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/repositories/wallpaper_repository.dart';
import 'package:wallpaper_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:wallpaper_app/shared_libraries/utils/error/failure_response.dart';

class WallpaperRepositoryImpl implements WallpaperRepository {
  final WallpaperRemoteDatasource wallpaperRemoteDatasource;
  final WallpaperMapper wallpaperMapper;

  WallpaperRepositoryImpl({
    required this.wallpaperRemoteDatasource,
    required this.wallpaperMapper,
  });

  @override
  Future<Either<FailureResponse, List<PhotoResponseEntity>>>
      getCurated() async {
    try {
      final response = await wallpaperRemoteDatasource.getCuratedPhotos();
      return Right(wallpaperMapper.mapPhotoResponseDtoToEntity(response.data!));
    } on DioException catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
          statusCode: error.response?.statusCode ?? 500,
        ),
      );
    }
  }
}
