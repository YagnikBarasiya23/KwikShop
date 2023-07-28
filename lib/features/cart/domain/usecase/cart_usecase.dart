import 'package:kwikshop/core/usecase/usecase.dart';
import 'package:kwikshop/features/cart/domain/repository/cart_repository.dart';

class CartUseCase implements UseCase<void, OrderItem> {
  const CartUseCase(this._cartRepository);
  final CartRepository _cartRepository;
  @override
  void call({required params}) => _cartRepository.setOrder(
        params.index,
        params.product,
        params.image,
        params.price,
        params.quantity,
        params.orderId,
      );
}

class OrderItem {
  final String product;
  final String image;
  final int index;
  final double price;
  final int quantity;
  final String orderId;
  const OrderItem({
    required this.image,
    required this.product,
    required this.quantity,
    required this.index,
    required this.price,
    required this.orderId,
  });
}
