class AddToCartRespose {
  final int productId;
  final int cartItemId;
  final int count;

  AddToCartRespose.fromjson(Map<String, dynamic> json)
      : productId = json['product_id'],
        cartItemId = json['id'],
        count = json['count'];
}
