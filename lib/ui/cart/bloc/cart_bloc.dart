import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:nike_2/common/exception.dart';
import 'package:nike_2/data/auth.dart';
import 'package:nike_2/data/cart_response.dart';
import 'package:nike_2/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc({required this.cartRepository}) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      //get cart items
      if (event is CartStarted) {
        if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          await loadCartStates(emit, event.isRefreshing);
        }
        //delete car item
      } else if (event is CartDeleteButtonClicked) {
        try {
          final successState = (state as CartSuccess);
          final index = successState.cartResponse.cartItems
              .indexWhere((element) => element.id == event.cartItemId);
          successState.cartResponse.cartItems[index].deleteButtonLoading = true;
          emit(CartSuccess(cartResponse: successState.cartResponse));
          await cartRepository.remove(event.cartItemId);
          await cartRepository.count();
          successState.cartResponse.cartItems
              .removeWhere((element) => element.id == event.cartItemId);
          if (successState.cartResponse.cartItems.isEmpty) {
            emit(CartEmpty());
          } else {
            emit(calculatePriceInfo(successState.cartResponse));
          }
        } catch (e) {
          debugPrint(e.toString());
        }
        //check user authentication
      } else if (event is CartAuthInfoChanged) {
        if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          if (state is CartAuthRequired) {
            await loadCartStates(emit, false);
          }
        }
      } else if (event is CartDecreaseButtonClicked ||
          event is CartIncreaseButtonClicked) {
        try {
          int cartItemId = 0;
          if (event is CartDecreaseButtonClicked) {
            cartItemId = event.cartItemId;
          } else if (event is CartIncreaseButtonClicked) {
            cartItemId = event.cartItemId;
          }

          final successState = (state as CartSuccess);
          final index = successState.cartResponse.cartItems
              .indexWhere((element) => element.id == cartItemId);
          successState.cartResponse.cartItems[index].changeCountButtonLoading =
              true;
          emit(CartSuccess(cartResponse: successState.cartResponse));
          int newCount = event is CartIncreaseButtonClicked
              ? ++successState.cartResponse.cartItems[index].count
              : --successState.cartResponse.cartItems[index].count;
          //change count from server
          await cartRepository.changeCount(cartItemId, newCount);
          await cartRepository.count();
          //change count from datasource
          successState.cartResponse.cartItems
              .firstWhere((element) => element.id == cartItemId)
            ..count = newCount
            ..changeCountButtonLoading = false;
          //calculate prices in ui(without refresh)
          emit(calculatePriceInfo(successState.cartResponse));
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    });
  }

  Future<void> loadCartStates(
      Emitter<CartState> emit, bool isRefreshing) async {
    try {
      if (!isRefreshing) {
        emit(CartLoading());
      }
      final result = await cartRepository.getAll();
      if (result.cartItems.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartSuccess(cartResponse: result));
      }
    } catch (e) {
      emit(CartError(exception: AppException()));
    }
  }

  CartSuccess calculatePriceInfo(CartResponse cartResponse) {
    int totalPrice = 0;
    int payablePrice = 0;
    int shippingCost = 0;
    cartResponse.cartItems.forEach((cartItem) {
      totalPrice += cartItem.product.previousPrice * cartItem.count;
      payablePrice += cartItem.product.price * cartItem.count;
    });

    shippingCost = payablePrice >= 250000 ? 0 : 50000;

    cartResponse.totalPrice = totalPrice;
    cartResponse.payablePrice = payablePrice;
    cartResponse.shippingCost = shippingCost;

    return CartSuccess(cartResponse: cartResponse);
  }
}
