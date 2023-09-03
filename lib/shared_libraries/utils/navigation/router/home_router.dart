import '../../navigation/navigation_helper.dart';
import 'app_routes.dart';

abstract class HomeRouter {
  void navigateToOtherScreen();
}

class HomeRouterImpl implements HomeRouter {
  final NavigationHelper navigationHelper;

  HomeRouterImpl({required this.navigationHelper});

  @override
  void navigateToOtherScreen() {
    navigationHelper.pushNamed(AppRoutes.other);
  }
}
