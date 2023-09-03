import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/presentation/home/bloc/trending_photos_cubit/trending_photos_cubit.dart';
import 'package:wallpaper_app/presentation/home/bloc/trending_photos_cubit/trending_photos_state.dart';
import 'package:wallpaper_app/presentation/home/ui/component/search_card.dart';
import 'package:wallpaper_app/shared_libraries/component/loading/shimmer_loading.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/categories.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/shared_libraries/utils/state/view_data_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.4,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final data = categories[index];
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
              },
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              'Trending',
              style: TextStyle(
                color: ColorName.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            BlocBuilder<TrendingPhotosCubit, TrendingPhotosState>(
              builder: (context, state) {
                return state.trendingPhotosState.observe(
                  onLoading: MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
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
                  ),
                  (data) => MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      final photo = data[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
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
