import 'package:dio/dio.dart';
import 'package:wallpaper_app/domains/wallpaper/data/models/response/photo_response_dto.dart';
import 'package:wallpaper_app/shared_libraries/core/network/models/api_response.dart';
import 'package:wallpaper_app/shared_libraries/utils/constants/app_constants.dart';

abstract class WallpaperRemoteDatasource {
  Future<ApiResponse<List<PhotoResponseDto>>> getTrendingPhotos(
      {required int page});
}

class WallpaperRemoteDatasourceImpl implements WallpaperRemoteDatasource {
  final Dio dio;

  WallpaperRemoteDatasourceImpl({required this.dio});

  @override
  Future<ApiResponse<List<PhotoResponseDto>>> getTrendingPhotos(
      {required int page}) async {
    try {
      final response = await dio.get(
        AppConstants.appApi.curated,
        data: {'page': page},
      );
      return ApiResponse.fromJson(
        response.data,
        onDataDeserialized: (json) => List<PhotoResponseDto>.from(
          json.map(
            (x) => PhotoResponseDto.fromJson(x),
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
