import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class SetPhotoState extends Equatable {
  final ViewData setPhotoState;

  const SetPhotoState({required this.setPhotoState});

  @override
  List<Object?> get props => [setPhotoState];
}
