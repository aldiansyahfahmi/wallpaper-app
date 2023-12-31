import 'package:wallpaper_app/domains/wallpaper/data/models/body/photo_request_dto.dart';
import 'package:wallpaper_app/domains/wallpaper/data/models/response/photo_response_dto.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/body/photo_request_entity.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/shared_libraries/core/network/models/api_response.dart';

class WallpaperMapper {
  ApiResponse<List<PhotoResponseEntity>> mapApiResponseDtoToEntity(
          ApiResponse<List<PhotoResponseDto>> data) =>
      ApiResponse(
        nextPage: data.nextPage,
        page: data.page,
        perPage: data.perPage,
        prefPage: data.prefPage,
        totalResults: data.totalResults,
        data: mapPhotoResponseDtoToEntity(data.data!),
        onDeserialized: (_) => [],
      );
  List<PhotoResponseEntity> mapPhotoResponseDtoToEntity(
      List<PhotoResponseDto> data) {
    List<PhotoResponseEntity> entity = [];

    for (PhotoResponseDto element in data) {
      entity.add(mapPhotoResponseDtoToPhotoResponseEntity(element));
    }

    return entity;
  }

  PhotoResponseEntity mapPhotoResponseDtoToPhotoResponseEntity(
          PhotoResponseDto data) =>
      PhotoResponseEntity(
        id: data.id ?? 0,
        width: data.width ?? 0,
        height: data.height ?? 0,
        url: data.url ?? '',
        photographer: data.photographer ?? '',
        photographerUrl: data.photographerUrl ?? '',
        photographerId: data.photographerId ?? 0,
        avgColor: data.avgColor ?? '',
        src: mapSrcDtoToSrcEntity(data.src ?? SrcDto()),
        liked: data.liked ?? false,
        alt: data.alt ?? '',
      );

  SrcEntity mapSrcDtoToSrcEntity(SrcDto data) => SrcEntity(
        original: data.original ?? '',
        large2X: data.large2X ?? '',
        large: data.large ?? '',
        medium: data.medium ?? '',
        small: data.small ?? '',
        portrait: data.portrait ?? '',
        landscape: data.landscape ?? '',
        tiny: data.tiny ?? '',
      );

  PhotoRequestDto mapPhotoRequestEntityToPhotoRequestDto(
          PhotoRequestEntity data) =>
      PhotoRequestDto(
        endpoint: data.endpoint,
        page: data.page,
      );
}
