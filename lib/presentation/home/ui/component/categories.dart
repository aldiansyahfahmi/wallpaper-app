import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/injections/injections.dart';
import 'package:wallpaper_app/shared_libraries/component/card/category_card.dart';
import 'package:wallpaper_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/arguments/photos_argument.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/router/home_router.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/categories.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';

class Categories extends StatelessWidget {
  Categories({super.key});

  final HomeRouter _homeRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Categories',
              style: TextStyle(
                color: ColorName.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              'View More',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.4,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final data = categories[index];
            return GestureDetector(
              onTap: () => _homeRouter.navigateToPhotosScreen(
                argument: PhotosArgument(
                  title: data.name,
                  endpoint: AppConstants.appApi.search + data.name,
                ),
              ),
              child: CategoryCard(data: data),
            );
          },
        ),
      ],
    );
  }
}
