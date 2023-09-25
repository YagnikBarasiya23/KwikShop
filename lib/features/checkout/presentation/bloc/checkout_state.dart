part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();
  
  @override
  List<Object> get props => [];
}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoad extends CheckoutState{
  final MapModel mapModel;
  const CheckoutLoad({required this.mapModel});
  @override
  List<Object> get props => [mapModel];
}