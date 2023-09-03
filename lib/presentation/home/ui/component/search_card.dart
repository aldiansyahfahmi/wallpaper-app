import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorName.darkGrey,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: ColorName.white,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Search',
            style: TextStyle(
              color: ColorName.white,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
