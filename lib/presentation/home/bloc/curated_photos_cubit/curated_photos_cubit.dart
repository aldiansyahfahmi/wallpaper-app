import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/usecases/get_curated_photos_usecase.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import '/shared_libraries/utils/usecase/usecase.dart';
import 'curated_photos_state.dart';

class CuratedPhotosCubit extends Cubit<CuratedPhotosState> {
  final GetCuratedPhotosUseCase getCuratedPhotosUseCase;

  CuratedPhotosCubit({required this.getCuratedPhotosUseCase})
      : super(CuratedPhotosState(curatedPhotosState: ViewData.initial()));

  void getCuratedPhotos() async {
    emit(CuratedPhotosState(curatedPhotosState: ViewData.loading()));
    final result = await getCuratedPhotosUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(
        CuratedPhotosState(
          curatedPhotosState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        CuratedPhotosState(
          curatedPhotosState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }
}
