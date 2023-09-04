import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/presentation/home/ui/component/categories.dart';
import 'package:wallpaper_app/presentation/home/ui/component/trending_photos.dart';
import 'package:wallpaper_app/presentation/home/ui/component/search_card.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.black,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SearchCard(),
            SizedBox(
              height: 24.h,
            ),
            Categories(),
            SizedBox(
              height: 24.h,
            ),
            TrendingPhotos(),
          ],
        ),
      ),
    );
  }
}
