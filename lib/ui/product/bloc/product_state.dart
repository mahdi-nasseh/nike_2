part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class ProductAddToCartButtonLoading extends ProductState {}

class ProductAddToCartButtonError extends ProductState {
  final AppException exception;

  const ProductAddToCartButtonError({required this.exception});
  @override
  List<Object> get props => [exception];
}

class ProductAddToCartButtonSuccess extends ProductState {}
