part of 'product_list_bloc.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

final class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final int sort;
  final List<ProductEntity> products;
  final List<String> sortName;

  const ProductListSuccess({
    required this.sortName,
    required this.sort,
    required this.products,
  });

  @override
  List<Object> get props => [sort, products, sortName];
}

class ProductlistError extends ProductListState {
  final AppException exception;

  const ProductlistError({required this.exception});

  @override
  List<Object> get props => [exception];
}
