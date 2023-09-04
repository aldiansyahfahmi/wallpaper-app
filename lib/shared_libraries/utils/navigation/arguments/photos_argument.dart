import 'package:equatable/equatable.dart';

class PhotosArgument extends Equatable {
  final String title;
  final String endpoint;

  const PhotosArgument({required this.title, required this.endpoint});
  @override
  List<Object?> get props => [title, endpoint];
}
