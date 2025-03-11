import 'package:dio/dio.dart';
import 'package:nike_2/data/banner.dart';
import 'package:nike_2/data/common/http_validate_respnse.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource
    with HttpValidateRespnse
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource({required this.httpClient});
  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('/banner/slider');
    validateResponse(response);
    final List<BannerEntity> banners = [];
    (response.data as List).forEach((element) {
      banners.add(BannerEntity.fromjson(element));
    });
    return banners;
  }
}
