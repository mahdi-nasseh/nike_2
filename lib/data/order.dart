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
