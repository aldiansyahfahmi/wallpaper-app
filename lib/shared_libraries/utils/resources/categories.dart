import 'package:wallpaper_app/shared_libraries/utils/resources/assets.gen.dart';

class Categories {
  final String name;
  final String path;

  Categories({required this.name, required this.path});
}

List<Categories> categories = [
  Categories(name: 'Nature', path: Assets.images.categories.nature.path),
  Categories(name: 'Animals', path: Assets.images.categories.animals.path),
  Categories(name: 'Cars', path: Assets.images.categories.cars.path),
  Categories(
      name: 'Technology', path: Assets.images.categories.technology.path),
];
