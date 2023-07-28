import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import '../../domain/repository/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  @override
  void setDetail(double latitude, double longitude, List<Placemark> placeMark) {
    final DocumentReference<Map<String, dynamic>> firebaseFirestore =
        FirebaseFirestore.instance
            .collection('ProfileDetails')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Location")
            .doc(FirebaseAuth.instance.currentUser!.uid);

    final Map<String, String> details = {
      'Latitude': latitude.toString(),
      'Longitude': longitude.toString(),
      'Name': placeMark.first.name.toString(),
      'Street': placeMark.first.street.toString(),
      'City': placeMark.first.locality.toString(),
      'PostalCode': placeMark.first.postalCode.toString(),
    };
    firebaseFirestore.set(details);
  }

  @override
  void setOrderDetails(double grandTotal, String storeName, String orderId) {
    final CollectionReference<Map<String, dynamic>> firebaseFirestoreOrder =
        FirebaseFirestore.instance
            .collection('Orders')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Order");

    final Map<String, dynamic> orderDetails = {
      'TotalPrice': grandTotal,
      'Date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
      'Time': DateFormat('KK:mm a').format(DateTime.now()),
      'ShopName': storeName,
    };
    firebaseFirestoreOrder.doc(orderId).set(orderDetails);
  }
}
