import 'package:geocoding/geocoding.dart';

abstract class CheckoutRepository {
  void setDetail(double latitude, double longitude, List<Placemark> placeMark);
  void setOrderDetails(double grandTotal, String storeName, String orderId);
}
