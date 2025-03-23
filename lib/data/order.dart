import 'package:nike_2/data/product.dart';

class CreateOrderResult {
  final int orderId;
  final String bankGatewayUrl;

  CreateOrderResult.fromjson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        bankGatewayUrl = json['bank_gateway_url'];
}

class CreateOrderParams {
  final String firstName;
  final String lastName;
  final String mobile;
  final String postalCode;
  final String address;
  final PaymentMethodes paymentMethodes;

  CreateOrderParams(
      {required this.firstName,
      required this.lastName,
      required this.mobile,
      required this.postalCode,
      required this.address,
      required this.paymentMethodes});
}

enum PaymentMethodes {
  online,
  cashOnDelivery,
}

class OrderEntity {
  final int id;
  final int payablePrice;
  final List<ProductEntity> items;

  OrderEntity({
    required this.id,
    required this.payablePrice,
    required this.items,
  });

  OrderEntity.fromjson(Map<String, dynamic> json)
      : id = json['id'],
        payablePrice = json['payable'],
        items = (json['order_items']['product'] as List)
            .map((e) => ProductEntity.fromjson(e))
            .toList();
}
