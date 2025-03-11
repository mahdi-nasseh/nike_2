class ProductEntity {
  final int id;
  final String title;
  final String imageUrl;
  final int price;
  final int discount;
  final int previousPrice;

  ProductEntity.fromjson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        discount = json['discount'],
        imageUrl = json['image'],
        previousPrice =
            json['previos_price'] ?? json['price'] - json['discount'];
}

class ProductSort {
  static const latest = 0;
  static const popular = 1;
  static const priceHighToLow = 2;
  static const priceLowToHigh = 3;
}
