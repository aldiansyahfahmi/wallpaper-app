import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/shared_libraries/component/loading/shimmer_loading.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    super.key,
    required this.photo,
  });

  final PhotoResponseEntity photo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        height: 160.h,
        imageUrl: photo.src.portrait,
        fit: BoxFit.cover,
        placeholder: (context, url) => ShimmerLoading(
          child: Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: ColorName.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.image,
          color: ColorName.white,
          size: 50,
        ),
      ),
    );
  }
}
