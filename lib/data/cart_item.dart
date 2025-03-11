import 'package:nike_2/data/product.dart';

class CartItem {
  final ProductEntity product;
  final int id;
  int count;
  bool deleteButtonLoading = false;
  bool changeCountButtonLoading = false;

  CartItem.fromjson(Map<String, dynamic> json)
      : product = ProductEntity.fromjson(json['product']),
        id = json['cart_item_id'],
        count = json['count'];

  static List<CartItem> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartItem> cartItems = [];
    jsonArray.forEach((element) {
      cartItems.add(CartItem.fromjson(element));
    });
    return cartItems;
  }
}
