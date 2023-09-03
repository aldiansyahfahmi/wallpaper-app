import 'package:equatable/equatable.dart';

class PhotosArgument extends Equatable {
  final String title;

  const PhotosArgument({required this.title});
  @override
  List<Object?> get props => [title];
}
