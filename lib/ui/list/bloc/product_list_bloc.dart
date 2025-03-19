import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_2/common/exception.dart';
import 'package:nike_2/data/product.dart';
import 'package:nike_2/data/repo/product_repository.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductRepository _productRepository;
  ProductListBloc({required IProductRepository productRepository})
      : _productRepository = productRepository, super(ProductListLoading()) {
    on<ProductListEvent>((event, emit) async {
      if (event is ProductListStarted) {
        emit(ProductListLoading());
        try {
          final products = await _productRepository.getAll(event.sort);
          emit(ProductListSuccess(
              sortName: ProductSort.names,
              sort: event.sort,
              products: products));
        } catch (e) {
          emit(ProductlistError(exception: AppException()));
        }
      }
    });
  }
}
