part of 'shipping_bloc.dart';

sealed class ShippingState extends Equatable {
  const ShippingState();

  @override
  List<Object> get props => [];
}

final class ShippingInitial extends ShippingState {}

class ShippingLoading extends ShippingState {}

class ShippingSuccess extends ShippingState {
  final CreateOrderResult result;

  const ShippingSuccess({required this.result});
}

class ShippingError extends ShippingState {
  final AppException exception;

  const ShippingError({required this.exception});
}
