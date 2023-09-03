import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/usecases/get_trending_photos_usecase.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import '/shared_libraries/utils/usecase/usecase.dart';
import 'trending_photos_state.dart';

class TrendingPhotosCubit extends Cubit<TrendingPhotosState> {
  final GetTrendingPhotosUseCase getTrendingPhotosUseCase;

  TrendingPhotosCubit({required this.getTrendingPhotosUseCase})
      : super(TrendingPhotosState(trendingPhotosState: ViewData.initial()));

  void getTrendingPhotos() async {
    emit(TrendingPhotosState(trendingPhotosState: ViewData.loading()));
    final result = await getTrendingPhotosUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(
        TrendingPhotosState(
          trendingPhotosState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        TrendingPhotosState(
          trendingPhotosState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }
}
