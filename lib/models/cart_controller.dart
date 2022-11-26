import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kwikshop/models/product_model.dart';

class CartController extends GetxController {
  final _products = {}.obs;
  void addProducts(Products product) {
    if (_products.containsKey(product)) {
      _products[product]++;
    } else {
      _products[product] = 1;
    }
    Get.snackbar(
      'Successfully added',
      'Your item is added to cart',
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(7),
    );
  }

  get product => _products;
  void removeProducts(Products product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product]--;
    }
  }

  void removeAllProducts() {
    _products.clear();
  }

  get productSubTotal => _products.entries
      .map((product) => product.key.productprice * product.value)
      .toList();

  get Total => _products.entries
      .map((product) => product.key.productprice * product.value)
      .toList()
      .reduce((value, element) => value + element);
}
