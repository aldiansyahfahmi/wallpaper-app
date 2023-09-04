import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/injections/injections.dart';
import 'package:wallpaper_app/presentation/photos/bloc/photos_cubit/photos_cubit.dart';
import 'package:wallpaper_app/presentation/photos/bloc/photos_cubit/photos_state.dart';
import 'package:wallpaper_app/shared_libraries/component/card/photo_card.dart';
import 'package:wallpaper_app/shared_libraries/component/loading/photo_loading.dart';
import 'package:wallpaper_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/arguments/photos_argument.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/router/home_router.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:wallpaper_app/shared_libraries/utils/state/view_data_state.dart';

class TrendingPhotos extends StatelessWidget {
  TrendingPhotos({super.key});

  final HomeRouter _homeRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 3
                        : 6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final photo = data[index];
                  return GestureDetector(
                      onTap: () => _homeRouter.navigateToPhotoPreviewScreen(
                          argument: photo),
                      child: PhotoCard(photo: photo));
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
