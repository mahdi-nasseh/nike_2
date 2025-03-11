import 'package:dio/dio.dart';
import 'package:nike_2/data/repo/auth_repository.dart';

final httpClient = Dio(BaseOptions(baseUrl: 'https://fapi.7learn.com/api/v1'))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final authInfo = AuthRepository.authChangeNotifire.value;
      if (authInfo != null && authInfo.accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ${authInfo.accessToken}';
      }

      handler.next(options);
    },
  ));
