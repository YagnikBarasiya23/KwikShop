import 'package:kwikshop/features/categories/domain/entities.dart';

class Product {
  final String productName;
  final double productPrice;
  final String productImage;
  final Categories productCategory;
  final String productAmount;
  const Product({
    required this.productAmount,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productCategory,
  });
}
