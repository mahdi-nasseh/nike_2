part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductAddToCartButtonClicked extends ProductEvent {
  final int productId;

  const ProductAddToCartButtonClicked({required this.productId});
}
