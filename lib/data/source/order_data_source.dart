import 'package:dio/dio.dart';
import 'package:nike_2/data/order.dart';
import 'package:nike_2/data/payment_receipt.dart';

abstract class IOrderDataSource {
  Future<CreateOrderResult> create(CreateOrderParams params);
  Future<PaymentReceiptData> getPaymentReceipt(int orderId);
}

class RemoteOrderDataSource extends IOrderDataSource {
  final Dio httpClient;

  RemoteOrderDataSource({required this.httpClient});

  @override
  Future<CreateOrderResult> create(CreateOrderParams params) async {
    final response = await httpClient.post('/order/submit', data: {
      'first_name': params.firstName,
      'last_name': params.lastName,
      'mobile': params.mobile,
      'postal_code': params.postalCode,
      'address': params.address,
      'payment_method': params.paymentMethodes == PaymentMethodes.online
          ? 'online'
          : 'cash_on_delivery',
    });

    return CreateOrderResult.fromjson(response.data);
  }

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) async {
    final response = await httpClient.get('/order/checkout?order_id=$orderId');
    return PaymentReceiptData.fromjson(response.data);
  }
}
