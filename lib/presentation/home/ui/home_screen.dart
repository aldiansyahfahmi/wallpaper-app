import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/injections/injections.dart';
import 'package:wallpaper_app/presentation/photos/bloc/photos_cubit/photos_cubit.dart';
import 'package:wallpaper_app/presentation/photos/bloc/photos_cubit/photos_state.dart';
import 'package:wallpaper_app/presentation/home/ui/component/search_card.dart';
import 'package:wallpaper_app/shared_libraries/component/card/category_card.dart';
import 'package:wallpaper_app/shared_libraries/component/card/photo_card.dart';
import 'package:wallpaper_app/shared_libraries/component/loading/photo_loading.dart';
import 'package:wallpaper_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/arguments/photos_argument.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/router/home_router.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/categories.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/shared_libraries/utils/state/view_data_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeRouter _homeRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.black,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SearchCard(),
            SizedBox(
              height: 24.h,
            ),
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
            SizedBox(
              height: 24.h,
            ),
            Row(
              children: [
                Text(
                  'Trending',
                  style: TextStyle(
                    color: ColorName.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => _homeRouter.navigateToPhotosScreen(
                    argument: PhotosArgument(
                      title: 'Trending',
                      endpoint: AppConstants.appApi.curated,
                    ),
                  ),
                  child: Text(
                    'View More',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            BlocBuilder<PhotosCubit, PhotosState>(
              builder: (context, state) {
                return state.photosState.observe(
                  onLoading: const PhotoLoading(),
                  (data) => MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      final photo = data[index];
                      return PhotoCard(photo: photo);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
