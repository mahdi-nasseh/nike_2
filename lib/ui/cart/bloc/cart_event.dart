part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;
  final bool isRefreshing;
  const CartStarted({required this.authInfo, this.isRefreshing = false});
}

class CartRefresh extends CartEvent {}

class CartDeleteButtonClicked extends CartEvent {
  final int cartItemId;

  const CartDeleteButtonClicked({required this.cartItemId});
  @override
  List<Object> get props => [cartItemId];
}

class CartAuthInfoChanged extends CartEvent {
  final AuthInfo? authInfo;
  const CartAuthInfoChanged({required this.authInfo});
}

class CartIncreaseButtonClicked extends CartEvent {
  final int cartItemId;

  const CartIncreaseButtonClicked({required this.cartItemId});
  @override
  List<Object> get props => [cartItemId];
}

class CartDecreaseButtonClicked extends CartEvent {
  final int cartItemId;

  const CartDecreaseButtonClicked({required this.cartItemId});
  @override
  List<Object> get props => [cartItemId];
}
