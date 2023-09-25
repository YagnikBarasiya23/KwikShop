part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

final class OnLoadLocation extends CheckoutEvent {
  const OnLoadLocation();
}

final class CurrentLocationEvent extends CheckoutEvent {
  const CurrentLocationEvent();
}
