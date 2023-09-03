import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/presentation/home/bloc/trending_photos_cubit/trending_photos_cubit.dart';
import 'package:wallpaper_app/presentation/home/bloc/trending_photos_cubit/trending_photos_state.dart';
import 'package:wallpaper_app/shared_libraries/component/card/photo_card.dart';
import 'package:wallpaper_app/shared_libraries/component/loading/photo_loading.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/arguments/photos_argument.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:wallpaper_app/shared_libraries/utils/state/view_data_state.dart';

class PhotosScreen extends StatefulWidget {
  final PhotosArgument argument;
  const PhotosScreen({super.key, required this.argument});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  void initState() {
    context.read<TrendingPhotosCubit>().pagingController.addPageRequestListener(
      (pageKey) {
        context.read<TrendingPhotosCubit>().getTrendingPhotos(page: pageKey);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final trendingPhotosCubit = context.read<TrendingPhotosCubit>();
    return Scaffold(
      backgroundColor: ColorName.black,
      appBar: AppBar(
        backgroundColor: ColorName.black,
        centerTitle: true,
        title: Text(
          widget.argument.title,
          style: TextStyle(
            color: ColorName.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: BlocBuilder<TrendingPhotosCubit, TrendingPhotosState>(
        builder: (context, state) {
          return state.trendingPhotosState.observe(
            onLoading: const PhotoLoading(),
            (data) => PagedGridView<int, PhotoResponseEntity>(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              pagingController: trendingPhotosCubit.pagingController,
              builderDelegate: PagedChildBuilderDelegate<PhotoResponseEntity>(
                firstPageProgressIndicatorBuilder: (_) => const PhotoLoading(),
                itemBuilder: (context, item, index) => PhotoCard(photo: item),
              ),
            ),
          );
        },
      ),
    );
  }
}
