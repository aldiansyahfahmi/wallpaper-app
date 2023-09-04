import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/presentation/photo_preview/bloc/set_photo_cubit/set_photo_cubit.dart';
import 'package:wallpaper_app/presentation/photo_preview/bloc/set_photo_cubit/set_photo_state.dart';
import 'package:wallpaper_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:wallpaper_app/shared_libraries/utils/state/view_data_state.dart';

class PhotoPreviewScreen extends StatelessWidget {
  final PhotoResponseEntity argument;
  const PhotoPreviewScreen({super.key, required this.argument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorName.black,
        centerTitle: true,
      ),
      backgroundColor: ColorName.black,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton(
          backgroundColor: ColorName.white,
          onPressed: () => showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            isDismissible: true,
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 11, vertical: 24),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorName.white,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: ColorName.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1.sw,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: ColorName.darkGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.image,
                            size: 30,
                            color: ColorName.white,
                          ),
                          title: Text(
                            'Set Wallpaper',
                            style: TextStyle(
                              color: ColorName.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          onTap: () => context.read<SetPhotoCubit>().setPhoto(
                                imageUrl: argument.src.portrait,
                                setPhotoTo: SetPhotoTo.wallpaper,
                              ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.lock,
                            size: 30,
                            color: ColorName.white,
                          ),
                          title: Text(
                            'Set Lock Screen',
                            style: TextStyle(
                              color: ColorName.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          onTap: () => context.read<SetPhotoCubit>().setPhoto(
                                imageUrl: argument.src.portrait,
                                setPhotoTo: SetPhotoTo.lockScreen,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          child: const Icon(
            Icons.file_download_outlined,
            size: 30,
            color: ColorName.black,
          ),
        ),
      ),
      body: BlocListener<SetPhotoCubit, SetPhotoState>(
        listener: (context, state) {
          final status = state.setPhotoState.status;

          if (status.isHasData) {
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: 'Set Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 14.sp,
            );
          }

          if (status.isError) {
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: state.setPhotoState.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 14.sp,
            );
          }
        },
        child: Center(
          child: CachedNetworkImage(imageUrl: argument.src.portrait),
        ),
      ),
    );
  }
}
