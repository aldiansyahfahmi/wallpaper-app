import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/shared_libraries/component/loading/shimmer_loading.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';

class PhotoLoading extends StatelessWidget {
  const PhotoLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.portrait ? 3 : 6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: 15,
      itemBuilder: (context, index) {
        return ShimmerLoading(
          child: Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: ColorName.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}
