import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import 'package:wallpaper_app/presentation/photo_preview/bloc/set_photo_cubit/set_photo_cubit.dart';
import 'package:wallpaper_app/presentation/photo_preview/bloc/set_photo_cubit/set_photo_state.dart';
import 'package:wallpaper_app/presentation/photo_preview/ui/component/modal_bottom_sheet_card.dart';
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
              return ModalBottomSheetCard(argument: argument);
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
