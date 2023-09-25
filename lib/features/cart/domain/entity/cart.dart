import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/products.dart';

class Cart extends Equatable {
  final Map<Product, dynamic> cart;
  final List<double> productSubTotal;
  final double grandTotal;

  const Cart({
    required this.cart,
    required this.grandTotal,
    required this.productSubTotal,
  });

  @override
  List<Object?> get props => [cart, productSubTotal, grandTotal];
}
