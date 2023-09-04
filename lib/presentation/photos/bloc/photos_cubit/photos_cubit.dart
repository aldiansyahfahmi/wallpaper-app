import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/body/photo_request_entity.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/usecases/get_photos_usecase.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  final GetPhotosUseCase getPhotosUseCase;

  PhotosCubit({required this.getPhotosUseCase})
      : super(PhotosState(photosState: ViewData.initial()));

  final PagingController<int, PhotoResponseEntity> pagingController =
      PagingController(firstPageKey: 1);

  void getPhotos({required PhotoRequestEntity requestEntity}) async {
    emit(PhotosState(photosState: ViewData.loading()));
    final result = await getPhotosUseCase.call(requestEntity);
    result.fold(
      (failure) => emit(
        PhotosState(
          photosState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) {
        final isLastPage = result.data!.length < result.perPage!;
        if (result.data!.isEmpty) {
          emit(
            PhotosState(
              photosState: ViewData.noData(message: ''),
            ),
          );
        } else {
          emit(
            PhotosState(
              photosState: ViewData.loaded(data: result.data),
            ),
          );
        }
        if (isLastPage) {
          pagingController.appendLastPage(result.data!);
        } else {
          pagingController.appendPage(result.data!, requestEntity.page + 1);
        }
      },
    );
  }
}
