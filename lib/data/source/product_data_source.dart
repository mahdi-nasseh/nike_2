import 'package:nike_2/data/common/http_validate_respnse.dart';
import 'package:nike_2/data/product.dart';
import 'package:dio/dio.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource
    with HttpValidateRespnse
    implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource({required this.httpClient});
  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final response = await httpClient.get('/product/list?sort=$sort');
    validateResponse(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromjson(element));
    });
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('/product/search?q=$searchTerm');
    validateResponse(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromjson(element));
    });
    return products;
  }
}
