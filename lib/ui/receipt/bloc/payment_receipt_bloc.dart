import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_receipt_event.dart';
part 'payment_receipt_state.dart';

class PaymentReceiptBloc extends Bloc<PaymentReceiptEvent, PaymentReceiptState> {
  PaymentReceiptBloc() : super(PaymentReceiptLoading()) {
    on<PaymentReceiptEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
