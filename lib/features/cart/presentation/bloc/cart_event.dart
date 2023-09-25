part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class CartClear extends CartEvent {
  const CartClear();
}

final class AddItem extends CartEvent {
  final Product product;

  const AddItem({required this.product});

  @override
  List<Object> get props => [product];
}

final class RemoveItem extends CartEvent {
  final Product product;

  const RemoveItem({required this.product});

  @override
  List<Object> get props => [product];
}
