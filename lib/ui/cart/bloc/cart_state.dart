part of 'cart_bloc.dart';

sealed class CartState {
  const CartState();
}

final class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartResponse cartResponse;

  const CartSuccess({required this.cartResponse});
}

class CartError extends CartState {
  final AppException exception;

  const CartError({required this.exception});
}

class CartEmpty extends CartState {}

class CartAuthRequired extends CartState {}
