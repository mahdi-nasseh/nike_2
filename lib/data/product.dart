import 'package:hive_flutter/adapters.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class ProductEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final int discount;
  @HiveField(5)
  final int previousPrice;

  ProductEntity(
      {required this.discount,
      required this.id,
      required this.imageUrl,
      required this.previousPrice,
      required this.price,
      required this.title});

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

  static const List<String> names = [
    'جدیدترین',
    'محبوب‌ترین',
    'گران‌ترین',
    'ارزان‌ترین',
  ];
}
