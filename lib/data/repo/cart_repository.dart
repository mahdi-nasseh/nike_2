import 'package:flutter/cupertino.dart';
import 'package:nike_2/common/http_client.dart';
import 'package:nike_2/data/add_to_cart_response.dart';
import 'package:nike_2/data/cart_response.dart';
import 'package:nike_2/data/source/cart_data_source.dart';

final cartRepository =
    CartRepository(dataSource: CartRemoteDataSource(httpClient: httpClient));

abstract class ICartRepository extends ICartDataSource {}

class CartRepository with ChangeNotifier implements ICartRepository {
  final ICartDataSource dataSource;
  static ValueNotifier<int> cartItemCountNotifire = ValueNotifier(0);

  CartRepository({required this.dataSource});
  @override
  Future<AddToCartRespose> add(int productId) async {
    final result = await dataSource.add(productId);
    notifyListeners();
    return result;
  }

  @override
  Future<AddToCartRespose> changeCount(int cartItemid, int count) =>
      dataSource.changeCount(cartItemid, count);

  @override
  Future<int> count() async {
    final result = await dataSource.count();
    cartItemCountNotifire.value = result;
    return result;
  }

  @override
  Future<CartResponse> getAll() => dataSource.getAll();

  @override
  Future<void> remove(int cartItemId) => dataSource.remove(cartItemId);
}
