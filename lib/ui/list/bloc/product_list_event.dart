part of 'product_list_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListStarted extends ProductListEvent {
  final int sort;

  const ProductListStarted({required this.sort});
  @override
  List<Object> get props => [sort];
}
