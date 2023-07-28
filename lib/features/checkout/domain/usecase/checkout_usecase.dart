import 'package:geocoding/geocoding.dart';
import 'package:kwikshop/core/usecase/usecase.dart';
import 'package:kwikshop/features/checkout/domain/repository/checkout_repository.dart';

class CheckoutOrderDetailsUseCase implements UseCase<void, OrderDetails> {
  final CheckoutRepository _checkoutRepository;
  const CheckoutOrderDetailsUseCase(this._checkoutRepository);
  @override
  void call({required params}) => _checkoutRepository.setOrderDetails(
      params.grandTotal, params.storeName, params.orderId);
}

class CheckoutLocationDetailsUseCase implements UseCase<void, LocationDetails> {
  final CheckoutRepository _checkoutRepository;
  const CheckoutLocationDetailsUseCase(this._checkoutRepository);
  @override
  void call({required params}) => _checkoutRepository.setDetail(
      params.latitude, params.longitude, params.placeMark);
}

class LocationDetails {
  final double latitude;
  final double longitude;
  final List<Placemark> placeMark;
  const LocationDetails({
    required this.placeMark,
    required this.latitude,
    required this.longitude,
  });
}

class OrderDetails {
  final String orderId;
  final String storeName;
  final double grandTotal;
  const OrderDetails({
    required this.orderId,
    required this.storeName,
    required this.grandTotal,
  });
}
