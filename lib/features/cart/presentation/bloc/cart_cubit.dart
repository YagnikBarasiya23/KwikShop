import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwikshop/features/products/domain/entities/products.dart';

class CartCubit extends Cubit<Map<Product, dynamic>> {
  CartCubit() : super({});
  void add(Product product) {
    if (state.containsKey(product)) {
      state[product]++;
    } else {
      state[product] = 1;
    }
  }

  void remove(Product product) {
    if (state.containsKey(product) && state[product] == 1) {
      state.removeWhere((key, value) => key == product);
    } else {
      state[product]--;
    }
  }

  List<double> get productSubTotal => state.entries
      .map((product) => product.key.productPrice * product.value)
      .toList();

  double get grandTotal => state.entries
      .map((product) => product.key.productPrice * product.value)
      .toList()
      .reduce((value, element) => value + element);

  void clear() => state.clear();
}
