import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wallpaper_app/shared_libraries/utils/error/failure_response.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'set_photo_state.dart';

enum SetPhotoTo { wallpaper, lockScreen }

class SetPhotoCubit extends Cubit<SetPhotoState> {
  SetPhotoCubit() : super(SetPhotoState(setPhotoState: ViewData.initial()));

  void setPhoto(
      {required String imageUrl, required SetPhotoTo setPhotoTo}) async {
    emit(SetPhotoState(setPhotoState: ViewData.loading()));
    try {
      int location = setPhotoTo == SetPhotoTo.wallpaper
          ? WallpaperManager.HOME_SCREEN
          : WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(imageUrl);
      await WallpaperManager.setWallpaperFromFile(file.path, location);
      emit(SetPhotoState(setPhotoState: ViewData.loaded()));
    } catch (e) {
      emit(
        SetPhotoState(
          setPhotoState: ViewData.error(
            message: e.toString(),
            failure: FailureResponse(
              errorMessage: e.toString(),
              statusCode: 500,
            ),
          ),
        ),
      );
    }
  }
}
