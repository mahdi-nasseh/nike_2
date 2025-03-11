part of 'payment_receipt_bloc.dart';

sealed class PaymentReceiptState extends Equatable {
  const PaymentReceiptState();
  
  @override
  List<Object> get props => [];
}

final class PaymentReceiptLoading extends PaymentReceiptState {}

class PaymentReceiptSuccess extends PaymentReceiptState{}
