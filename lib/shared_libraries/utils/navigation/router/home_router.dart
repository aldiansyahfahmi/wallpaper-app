import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/arguments/photos_argument.dart';

import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class HomeRouter {
  void navigateToPhotosScreen({required PhotosArgument argument});
  void navigateToPhotoPreviewScreen({required PhotoResponseEntity argument});
  void navigateToSearchScreen();
}

class HomeRouterImpl implements HomeRouter {
  final NavigationHelper navigationHelper;

  HomeRouterImpl({required this.navigationHelper});

  @override
  void navigateToPhotosScreen({required PhotosArgument argument}) {
    navigationHelper.pushNamed(AppRoutes.photos, arguments: argument);
  }

  @override
  void navigateToPhotoPreviewScreen({required PhotoResponseEntity argument}) {
    navigationHelper.pushNamed(AppRoutes.photoPreview, arguments: argument);
  }

  @override
  void navigateToSearchScreen() {
    navigationHelper.pushNamed(AppRoutes.search);
  }
}
