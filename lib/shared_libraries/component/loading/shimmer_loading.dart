import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';

class ShimmerLoading extends StatelessWidget {
  final Widget child;
  const ShimmerLoading({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: ColorName.white,
      child: child,
    );
  }
}
