import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_2/common/exception.dart';
import 'package:nike_2/data/payment_receipt.dart';
import 'package:nike_2/data/repo/order_repository.dart';

part 'payment_receipt_event.dart';
part 'payment_receipt_state.dart';

class PaymentReceiptBloc
    extends Bloc<PaymentReceiptEvent, PaymentReceiptState> {
  final IOrderRepository orderRepository;
  PaymentReceiptBloc({required this.orderRepository})
      : super(PaymentReceiptLoading()) {
    on<PaymentReceiptEvent>((event, emit) async {
      if (event is PaymentReceiptStarted) {
        try {
          emit(PaymentReceiptLoading());
          final result = await orderRepository.getPaymentReceipt(event.orderId);
          emit(PaymentReceiptSuccess(result: result));
        } catch (e) {
          emit(PaymentReceiptError(exception: AppException()));
        }
      }
    });
  }
}
