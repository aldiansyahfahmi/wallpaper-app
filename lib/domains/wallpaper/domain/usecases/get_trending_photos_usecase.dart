import 'package:dartz/dartz.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/repositories/wallpaper_repository.dart';
import 'package:wallpaper_app/shared_libraries/core/network/models/api_response.dart';
import 'package:wallpaper_app/shared_libraries/utils/error/failure_response.dart';
import 'package:wallpaper_app/shared_libraries/utils/usecase/usecase.dart';

class GetTrendingPhotosUseCase
    extends UseCase<ApiResponse<List<PhotoResponseEntity>>, int> {
  final WallpaperRepository wallpaperRepository;

  GetTrendingPhotosUseCase({required this.wallpaperRepository});

  @override
  Future<Either<FailureResponse, ApiResponse<List<PhotoResponseEntity>>>> call(
          params) =>
      wallpaperRepository.getTrendingPhotos(page: params);
}
