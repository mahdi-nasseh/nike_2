import 'package:dio/dio.dart';
import 'package:nike_2/common/exception.dart';

mixin HttpValidateRespnse {
  void validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
