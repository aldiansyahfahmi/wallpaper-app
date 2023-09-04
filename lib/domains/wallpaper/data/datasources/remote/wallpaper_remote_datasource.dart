import 'package:dio/dio.dart';
import 'package:wallpaper_app/domains/wallpaper/data/models/body/photo_request_dto.dart';
import 'package:wallpaper_app/domains/wallpaper/data/models/response/photo_response_dto.dart';
import 'package:wallpaper_app/shared_libraries/core/network/models/api_response.dart';

abstract class WallpaperRemoteDatasource {
  Future<ApiResponse<List<PhotoResponseDto>>> getPhotos(
      {required PhotoRequestDto requestDto});
}

class WallpaperRemoteDatasourceImpl implements WallpaperRemoteDatasource {
  final Dio dio;

  WallpaperRemoteDatasourceImpl({required this.dio});

  @override
  Future<ApiResponse<List<PhotoResponseDto>>> getPhotos(
      {required PhotoRequestDto requestDto}) async {
    try {
      final response = await dio.get(
        requestDto.endpoint,
        queryParameters: {
          'per_page': 30,
          'page': requestDto.page,
        },
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
