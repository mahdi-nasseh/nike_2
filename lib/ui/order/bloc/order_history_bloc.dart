import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_2/common/exception.dart';
import 'package:nike_2/data/order.dart';
import 'package:nike_2/data/repo/order_repository.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final OrderRepository orderRepository;
  OrderHistoryBloc({required this.orderRepository})
      : super(OrderHistoryLoading()) {
    on<OrderHistoryEvent>((event, emit) async {
      if (event is OrderHistoryStarted) {
        try {
          emit(OrderHistoryLoading());
          final orders = await orderRepository.getOrders();
          emit(OrderHistorySuccess(orders: orders));
        } catch (e) {
          emit(OrderHistoryError(exception: AppException()));
        }
      }
    });
  }
}
