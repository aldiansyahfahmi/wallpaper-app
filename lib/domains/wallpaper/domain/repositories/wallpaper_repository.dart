import 'package:dartz/dartz.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/body/photo_request_entity.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/shared_libraries/core/network/models/api_response.dart';
import 'package:wallpaper_app/shared_libraries/utils/error/failure_response.dart';

abstract class WallpaperRepository {
  Future<Either<FailureResponse, ApiResponse<List<PhotoResponseEntity>>>>
      getTrendingPhotos({required PhotoRequestEntity requestEntity});
}
