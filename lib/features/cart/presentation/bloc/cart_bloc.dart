import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwikshop/features/cart/domain/entity/cart.dart';

import '../../../products/domain/entities/products.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartClear>(
      (event, emit) => emit(
        const CartLoad(
          cart: Cart(
            cart: {},
            grandTotal: 0,
            productSubTotal: [],
          ),
        ),
      ),
    );
    on<AddItem>((event, emit) {
      final state = this.state;
      if (state is CartLoad) {
        final cart = state.cart.cart;
        final Map<Product, dynamic> currentCart = Map.from(cart);
        if (currentCart.containsKey(event.product)) {
          currentCart[event.product]++;
        } else {
          currentCart[event.product] = 1;
        }
        List<double> productSubTotal = currentCart.entries
            .map((product) => product.key.productPrice * product.value)
            .toList();

        double grandTotal = currentCart.entries
            .map((product) => product.key.productPrice * product.value)
            .toList()
            .reduce((value, element) => value + element);
        emit(
          CartLoad(
            cart: Cart(
              cart: currentCart,
              grandTotal: grandTotal,
              productSubTotal: productSubTotal,
            ),
          ),
        );
      }
    });
    on<RemoveItem>((event, emit) {
      final state = this.state;
      if (state is CartLoad) {
        final cart = state.cart.cart;
        final Map<Product, dynamic> currentCart = Map.from(cart);
        if (currentCart.containsKey(event.product) &&
            currentCart[event.product] == 1) {
          currentCart.removeWhere((key, value) => key == event.product);
        } else {
          currentCart[event.product]--;
        }
        List<double> productSubTotal = cart.entries
            .map((product) => product.key.productPrice * product.value)
            .toList();

        double grandTotal = cart.entries
            .map((product) => product.key.productPrice * product.value)
            .toList()
            .reduce((value, element) => value + element);
        emit(
          CartLoad(
            cart: Cart(
              cart: currentCart,
              grandTotal: grandTotal,
              productSubTotal: productSubTotal,
            ),
          ),
        );
      }
    });
  }
}
