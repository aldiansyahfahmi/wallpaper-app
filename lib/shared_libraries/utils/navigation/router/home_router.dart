import 'package:wallpaper_app/shared_libraries/utils/navigation/arguments/photos_argument.dart';

import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class HomeRouter {
  void navigateToPhotosScreen({required PhotosArgument argument});
}

class HomeRouterImpl implements HomeRouter {
  final NavigationHelper navigationHelper;

  HomeRouterImpl({required this.navigationHelper});

  @override
  void navigateToPhotosScreen({required PhotosArgument argument}) {
    navigationHelper.pushNamed(AppRoutes.photos, arguments: argument);
  }
}
