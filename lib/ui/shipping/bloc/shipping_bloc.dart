import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_2/common/exception.dart';
import 'package:nike_2/data/order.dart';
import 'package:nike_2/data/repo/order_repository.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final IOrderRepository orderRepository;
  ShippingBloc({required this.orderRepository}) : super(ShippingInitial()) {
    on<ShippingEvent>((event, emit) async {
      if (event is ShippingCreateOrder) {
        try {
          emit(ShippingLoading());
          final result = await orderRepository.create(event.params);
          emit(ShippingSuccess(result: result));
        } catch (e) {
          emit(ShippingError(exception: AppException()));
        }
      }
    });
  }
}
