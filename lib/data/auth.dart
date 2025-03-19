class AuthInfo {
  final String refreshToken;
  final String accessToken;
  final String email; 

  AuthInfo(
      {required this.refreshToken,
      required this.accessToken,
      required this.email});
}
