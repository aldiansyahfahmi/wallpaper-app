import 'package:equatable/equatable.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class CuratedPhotosState extends Equatable {
  final ViewData<List<PhotoResponseEntity>> curatedPhotosState;

  const CuratedPhotosState({required this.curatedPhotosState});

  @override
  List<Object?> get props => [curatedPhotosState];
}
