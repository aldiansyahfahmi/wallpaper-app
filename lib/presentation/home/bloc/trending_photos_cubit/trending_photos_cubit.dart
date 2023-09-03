import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/usecases/get_trending_photos_usecase.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'trending_photos_state.dart';

class TrendingPhotosCubit extends Cubit<TrendingPhotosState> {
  final GetTrendingPhotosUseCase getTrendingPhotosUseCase;

  TrendingPhotosCubit({required this.getTrendingPhotosUseCase})
      : super(TrendingPhotosState(trendingPhotosState: ViewData.initial()));

  final PagingController<int, PhotoResponseEntity> pagingController =
      PagingController(firstPageKey: 1);

  void getTrendingPhotos({required int page}) async {
    emit(TrendingPhotosState(trendingPhotosState: ViewData.loading()));
    final result = await getTrendingPhotosUseCase.call(page);
    result.fold(
      (failure) => emit(
        TrendingPhotosState(
          trendingPhotosState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) {
        final isLastPage = result.data!.length < result.perPage!;
        if (result.data!.isEmpty) {
          emit(
            TrendingPhotosState(
              trendingPhotosState: ViewData.noData(message: ''),
            ),
          );
        } else {
          emit(
            TrendingPhotosState(
              trendingPhotosState: ViewData.loaded(data: result.data),
            ),
          );
        }
        if (isLastPage) {
          pagingController.appendLastPage(result.data!);
        } else {
          pagingController.appendPage(result.data!, page + 1);
        }
      },
    );
  }
}
