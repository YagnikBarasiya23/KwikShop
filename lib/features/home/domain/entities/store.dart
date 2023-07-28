import 'package:kwikshop/features/categories/domain/entities.dart';

class Store {
  final String storeName;
  final String storeAddress;
  final double storeRating;
  final String storeType;
  final String storeImage;
  final String id;
  final List<Categories> categories;

  const Store({
    required this.id,
    required this.storeImage,
    required this.storeAddress,
    required this.storeName,
    required this.storeRating,
    required this.storeType,
    required this.categories,
  });
}
