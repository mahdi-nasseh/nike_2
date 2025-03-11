class PaymentReceiptData {
  final bool purchaseSuccess;
  final String paymentStatus;
  final int payableprice;

  PaymentReceiptData.fromjson(Map<String, dynamic> json)
      : purchaseSuccess = json['purchase_success'],
        paymentStatus = json['payment_status'],
        payableprice = json['payable_price'];
}
