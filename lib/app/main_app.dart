import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/body/photo_request_entity.dart';
import 'package:wallpaper_app/injections/injections.dart';
import 'package:wallpaper_app/presentation/photos/bloc/photos_cubit/photos_cubit.dart';
import 'package:wallpaper_app/presentation/photos/ui/photos_screen.dart';
import 'package:wallpaper_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:wallpaper_app/shared_libraries/utils/navigation/arguments/photos_argument.dart';
import '../presentation/home/ui/home_screen.dart';
import '../shared_libraries/utils/navigation/navigation_helper.dart';
import '../shared_libraries/utils/navigation/router/app_routes.dart';
import '../shared_libraries/utils/resources/colors.gen.dart';
import '../shared_libraries/utils/setup/app_setup.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Wallpaper App',
          debugShowCheckedModeBanner: Config.isDebug,
          theme: ThemeData(
            scaffoldBackgroundColor: ColorName.white,
          ),
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            );
          },
          home: BlocProvider(
            create: (context) => PhotosCubit(
              getPhotosUseCase: sl(),
            )..getPhotos(
                requestEntity: PhotoRequestEntity(
                  endpoint: AppConstants.appApi.curated,
                  page: 1,
                ),
              ),
            child: HomeScreen(),
          ),
          navigatorKey: NavigationHelperImpl.navigatorKey,
          onGenerateRoute: (settings) {
            final argument = settings.arguments;
            switch (settings.name) {
              case AppRoutes.photos:
                return PageTransition(
                  child: BlocProvider(
                    create: (context) => PhotosCubit(
                      getPhotosUseCase: sl(),
                    ),
                    child: PhotosScreen(argument: argument as PhotosArgument),
                  ),
                  type: PageTransitionType.rightToLeft,
                );
              default:
                return PageTransition(
                  child: HomeScreen(),
                  type: PageTransitionType.rightToLeft,
                );
            }
          },
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(context, child, details) {
    return child;
  }
}
