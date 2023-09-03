import 'package:dartz/dartz.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/shared_libraries/utils/error/failure_response.dart';

abstract class WallpaperRepository {
  Future<Either<FailureResponse, List<PhotoResponseEntity>>> getCurated();
}
