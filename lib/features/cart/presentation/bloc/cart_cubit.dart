import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwikshop/features/products/domain/entities/products.dart';

class CartCubit extends Cubit<Map<Product, dynamic>> {
  CartCubit() : super({});
  void add(Product product) {
    final Map<Product, dynamic> currentCart = Map.from(state);
    if (currentCart.containsKey(product)) {
      currentCart[product]++;
    } else {
      currentCart[product] = 1;
    }
    emit(currentCart);
  }

  void remove(Product product) {
    final Map<Product, dynamic> currentCart = Map.from(state);
    if (currentCart.containsKey(product) && currentCart[product] == 1) {
      currentCart.removeWhere((key, value) => key == product);
    } else {
      currentCart[product]--;
    }
    emit(currentCart);
  }

  List<double> get productSubTotal => state.entries
      .map((product) => product.key.productPrice * product.value)
      .toList();

  double get grandTotal => state.entries
      .map((product) => product.key.productPrice * product.value)
      .toList()
      .reduce((value, element) => value + element);

  void clear() {
    final Map<Product, dynamic> currentCart = Map.from(state);
    currentCart.clear();
    emit(currentCart);
  }
}
