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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(
            color: ColorName.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 4,
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
