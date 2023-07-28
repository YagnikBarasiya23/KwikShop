import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kwikshop/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  @override
  void setOrder(int index, String product, String image, double price,
      int quantity, String orderId) {
    final CollectionReference<Map<String, dynamic>> firebaseFirestore =
        FirebaseFirestore.instance
            .collection('Orders')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Order");

    final Map<String, dynamic> item = {
      'Product': product,
      'Image': image,
      'Price': price,
      'Quantity': quantity,
    };
    firebaseFirestore
        .doc(orderId)
        .collection('Items')
        .doc(index.toString())
        .set(item);
  }
}
