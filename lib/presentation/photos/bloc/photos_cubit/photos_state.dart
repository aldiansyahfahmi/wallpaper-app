import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class PhotosState extends Equatable {
  final ViewData photosState;

  const PhotosState({required this.photosState});

  @override
  List<Object?> get props => [photosState];
}
