import 'package:dio/dio.dart';
import 'package:nike_2/data/auth.dart';
import 'package:nike_2/data/common/constants.dart';
import 'package:nike_2/data/common/http_validate_respnse.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> register(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource with HttpValidateRespnse implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource({required this.httpClient});
  @override
  Future<AuthInfo> login(String username, String password) async {
    final response = await httpClient.post('/auth/token', data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constants.clientSecret,
      "username": username,
      "password": password
    });
    validateResponse(response);
    return AuthInfo(
        refreshToken: response.data['refresh_token'],
        accessToken: response.data['access_token']);
  }

  @override
  Future<AuthInfo> refreshToken(String token) async {
    final response = await httpClient.post('/auth/token', data: {
      'grant_type': 'refresh_token',
      'refresh_token': token,
      'client_id': 2,
      'client_secret': Constants.clientSecret,
    });
    validateResponse(response);

    return AuthInfo(
        refreshToken: response.data['refresh_token'],
        accessToken: response.data['access_token']);
  }

  @override
  Future<AuthInfo> register(String username, String password) async {
    final response = await httpClient.post('/user/register',
        data: {'email': username, 'password': password});
    validateResponse(response);

    return login(username, password);
  }
}
