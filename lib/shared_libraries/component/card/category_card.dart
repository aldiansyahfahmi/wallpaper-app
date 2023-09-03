import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/categories.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.data,
  });

  final Categories data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorName.darkGrey,
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(data.path),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            ColorName.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Text(
          data.name,
          style: TextStyle(
            color: ColorName.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
