import 'package:nike_2/common/http_client.dart';
import 'package:nike_2/data/product.dart';
import 'package:nike_2/data/source/product_data_source.dart';

final productRepository = ProductRepository(
    dataSource: ProductRemoteDataSource(httpClient: httpClient));

abstract class IProductRepository {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository({required this.dataSource});
  @override
  Future<List<ProductEntity>> getAll(int sort) => dataSource.getAll(sort);

  @override
  Future<List<ProductEntity>> search(String searchTerm) =>
      dataSource.search(searchTerm);
}
