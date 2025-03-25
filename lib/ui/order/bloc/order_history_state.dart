part of 'order_history_bloc.dart';

sealed class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

final class OrderHistoryLoading extends OrderHistoryState {}

class OrderHistoryError extends OrderHistoryState {
  final AppException exception;

  const OrderHistoryError({required this.exception});
  @override
  List<Object> get props => [exception];
}

class OrderHistorySuccess extends OrderHistoryState {
  final List<OrderEntity> orders;

  const OrderHistorySuccess({required this.orders});

  @override
  List<Object> get props => [orders];
}
