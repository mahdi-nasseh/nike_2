import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_2/common/exception.dart';
import 'package:nike_2/data/repo/cart_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository cartRepository;
  ProductBloc({required this.cartRepository}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is ProductAddToCartButtonClicked) {
        try {
          emit(ProductAddToCartButtonLoading());
          await cartRepository.add(event.productId);
          await cartRepository.count();
          
          emit(ProductAddToCartButtonSuccess());
        } catch (e) {
          emit(
            ProductAddToCartButtonError(
              exception: AppException(),
            ),
          );
        }
      }
    });
  }
}
