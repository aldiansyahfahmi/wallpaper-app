import 'package:wallpaper_app/domains/wallpaper/data/models/response/photo_response_dto.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';

class WallpaperMapper {
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
}
