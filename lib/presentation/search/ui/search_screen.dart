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
import 'package:wallpaper_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/router/home_router.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final HomeRouter _homeRouter = sl();

  final _searchController = TextEditingController();

  bool isFirstLaunch = true;

  @override
  void initState() {
    context.read<PhotosCubit>().pagingController.addPageRequestListener(
      (pageKey) {
        if (_searchController.text.isNotEmpty) {
          isFirstLaunch = false;
        }
        context.read<PhotosCubit>().getPhotos(
              requestEntity: PhotoRequestEntity(
                endpoint: isFirstLaunch || _searchController.text.isEmpty
                    ? AppConstants.appApi.curated
                    : AppConstants.appApi.search +
                        _searchController.text.trim(),
                page: pageKey,
              ),
            );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    context.read<PhotosCubit>().pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photosCubit = context.read<PhotosCubit>();
    return Scaffold(
      backgroundColor: ColorName.black,
      appBar: AppBar(
        backgroundColor: ColorName.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              style: TextStyle(
                color: ColorName.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              onFieldSubmitted: (value) {
                photosCubit.pagingController.refresh();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorName.darkGrey,
                hintText: 'Search...',
                hintStyle: TextStyle(
                  color: ColorName.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    photosCubit.pagingController.refresh();
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.amber,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: PagedGridView<int, PhotoResponseEntity>(
                shrinkWrap: true,
                showNewPageErrorIndicatorAsGridChild: false,
                showNewPageProgressIndicatorAsGridChild: false,
                showNoMoreItemsIndicatorAsGridChild: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                pagingController: photosCubit.pagingController,
                builderDelegate: PagedChildBuilderDelegate<PhotoResponseEntity>(
                  firstPageProgressIndicatorBuilder: (_) =>
                      const PhotoLoading(),
                  newPageProgressIndicatorBuilder: (_) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorName.white,
                      ),
                    ),
                  ),
                  itemBuilder: (context, item, index) => GestureDetector(
                      onTap: () => _homeRouter.navigateToPhotoPreviewScreen(
                          argument: item),
                      child: PhotoCard(photo: item)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
