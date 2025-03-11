import 'package:nike_2/data/cart_item.dart';

class CartResponse {
  final List<CartItem> cartItems;
   int payablePrice;
   int totalPrice;
   int shippingCost;

  CartResponse.fromjson(Map<String, dynamic> json)
      : cartItems = CartItem.parseJsonArray(json['cart_items']),
        payablePrice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingCost = json['shipping_cost'];
}
