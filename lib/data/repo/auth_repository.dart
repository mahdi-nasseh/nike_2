import 'package:flutter/material.dart';
import 'package:nike_2/common/http_client.dart';
import 'package:nike_2/data/auth.dart';
import 'package:nike_2/data/source/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository =
    AuthRepository(dataSource: AuthRemoteDataSource(httpClient: httpClient));

abstract class IAuthRepository {
  Future<void> login(username, password);
  Future<void> register(username, password);
  Future<void> refreshToken();
  Future<void> signout();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifire = ValueNotifier(null);
  final IAuthDataSource dataSource;

  AuthRepository({required this.dataSource});
  @override
  Future<void> login(username, password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _persistsAuthTokens(authInfo);
  }

  @override
  Future<void> register(username, password) async {
    final AuthInfo authInfo = await dataSource.register(username, password);
    _persistsAuthTokens(authInfo);
  }

  @override
  Future<void> refreshToken() async {
    final AuthInfo authInfo =
        await dataSource.refreshToken(authChangeNotifire.value!.refreshToken);
        debugPrint("Refresh Token is: ${authInfo.refreshToken};");
    _persistsAuthTokens(authInfo);
  }

  Future<void> _persistsAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setString('refresh_token', authInfo.refreshToken);
    sharedPreferences.setString('access_token', authInfo.accessToken);
    loadAuthInfo();
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString('access_token') ?? '';
    final String refreshToken =
        sharedPreferences.getString('refresh_token') ?? '';

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifire.value =
          AuthInfo(refreshToken: refreshToken, accessToken: accessToken);
    }
  }

  @override
  Future<void> signout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifire.value = null;
  }
}
