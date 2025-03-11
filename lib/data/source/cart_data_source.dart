import 'package:dio/dio.dart';
import 'package:nike_2/data/add_to_cart_response.dart';
import 'package:nike_2/data/cart_response.dart';

abstract class ICartDataSource {
  Future<AddToCartRespose> add(int productId);
  Future<AddToCartRespose> changeCount(int cartItemid, int count);
  Future<void> remove(int cartItemId);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRemoteDataSource implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource({required this.httpClient});
  @override
  Future<AddToCartRespose> add(int productId) async {
    final response = await httpClient.post('/cart/add', data: {
      'product_id': productId,
    });

    return AddToCartRespose.fromjson(response.data);
  }

  @override
  Future<AddToCartRespose> changeCount(int cartItemid, int count) async {
    final response = await httpClient.post('/cart/changeCount', data: {
      'cart_item_id': cartItemid,
      'count': count,
    });

    return AddToCartRespose.fromjson(response.data);
  }

  @override
  Future<int> count() async {
    final response = await httpClient.get('/cart/count');
    return response.data['count'];
  }

  @override
  Future<CartResponse> getAll() async {
    final response = await httpClient.get('/cart/list');
    return CartResponse.fromjson(response.data);
  }

  @override
  Future<void> remove(int cartItemId) async {
    await httpClient.post('/cart/remove', data: {'cart_item_id': cartItemId});
  }
}
