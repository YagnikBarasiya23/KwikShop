part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoad extends CartState {
  final Cart cart;

  const CartLoad({required this.cart});

  @override
  List<Object> get props => [cart];
}
