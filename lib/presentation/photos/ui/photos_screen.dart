import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/body/photo_request_entity.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/injections/injections.dart';
import 'package:wallpaper_app/presentation/photos/bloc/photos_cubit/photos_cubit.dart';
import 'package:wallpaper_app/shared_libraries/component/card/photo_card.dart';
import 'package:wallpaper_app/shared_libraries/component/loading/photo_loading.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/arguments/photos_argument.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/router/home_router.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';

class PhotosScreen extends StatefulWidget {
  final PhotosArgument argument;
  const PhotosScreen({super.key, required this.argument});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final HomeRouter _homeRouter = sl();
  @override
  void initState() {
    context.read<PhotosCubit>().pagingController.addPageRequestListener(
      (pageKey) {
        context.read<PhotosCubit>().getPhotos(
              requestEntity: PhotoRequestEntity(
                endpoint: widget.argument.endpoint,
                page: pageKey,
              ),
            );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final photosCubit = context.read<PhotosCubit>();
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
      body: PagedGridView<int, PhotoResponseEntity>(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        showNewPageErrorIndicatorAsGridChild: false,
        showNewPageProgressIndicatorAsGridChild: false,
        showNoMoreItemsIndicatorAsGridChild: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 3
                  : 6,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        pagingController: photosCubit.pagingController,
        builderDelegate: PagedChildBuilderDelegate<PhotoResponseEntity>(
          firstPageProgressIndicatorBuilder: (_) => const PhotoLoading(),
          newPageProgressIndicatorBuilder: (_) => const Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: CircularProgressIndicator(
                color: ColorName.white,
              ),
            ),
          ),
          itemBuilder: (context, item, index) => GestureDetector(
              onTap: () =>
                  _homeRouter.navigateToPhotoPreviewScreen(argument: item),
              child: PhotoCard(photo: item)),
        ),
      ),
    );
  }
}
