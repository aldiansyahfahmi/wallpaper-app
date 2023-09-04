import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper_app/domains/wallpaper/data/datasources/remote/wallpaper_remote_datasource.dart';
import 'package:wallpaper_app/domains/wallpaper/data/mapper/wallpaper_mapper.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/body/photo_request_entity.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/repositories/wallpaper_repository.dart';
import 'package:wallpaper_app/shared_libraries/core/network/models/api_response.dart';
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
  Future<Either<FailureResponse, ApiResponse<List<PhotoResponseEntity>>>>
      getTrendingPhotos({required PhotoRequestEntity requestEntity}) async {
    try {
      final response = await wallpaperRemoteDatasource.getPhotos(
          requestDto: wallpaperMapper
              .mapPhotoRequestEntityToPhotoRequestDto(requestEntity));
      return Right(wallpaperMapper.mapApiResponseDtoToEntity(response));
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
