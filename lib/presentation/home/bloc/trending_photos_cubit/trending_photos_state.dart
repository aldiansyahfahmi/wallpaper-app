import 'package:equatable/equatable.dart';
import 'package:wallpaper_app/domains/wallpaper/domain/entities/response/photo_response_entity.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class TrendingPhotosState extends Equatable {
  final ViewData<List<PhotoResponseEntity>> trendingPhotosState;

  const TrendingPhotosState({required this.trendingPhotosState});

  @override
  List<Object?> get props => [trendingPhotosState];
}
