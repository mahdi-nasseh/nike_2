import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nike_2/data/product.dart';

class FavoriteManager {
  static const String boxName = 'favorite';
  final box = Hive.box<ProductEntity>(boxName);
  ValueListenable<Box<ProductEntity>> get listenable =>
      Hive.box<ProductEntity>(boxName).listenable();
  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<ProductEntity>(ProductEntityAdapter());
    Hive.openBox<ProductEntity>(boxName);
  }

  void addFavorite(ProductEntity product) {
    box.put(product.id, product);
  }

  void removeFavorite(ProductEntity product) {
    box.delete(product.id);
  }

  List<ProductEntity> get favorites => box.values.toList();

  bool isFavorite(ProductEntity product) {
    return box.containsKey(product.id);
  }
}
