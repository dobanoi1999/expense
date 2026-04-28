import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();

  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  Future<void> clearRefreshToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final storage = FlutterSecureStorage();
  static const _kToken = 'auth_token';
  static const _kRefreshToken = 'auth_refresh_token';

  @override
  Future<void> saveToken(String token) =>
      storage.write(key: _kToken, value: token);

  @override
  Future<String?> getToken() => storage.read(key: _kToken);

  @override
  Future<void> clearToken() => storage.delete(key: _kToken);

  @override
  Future<void> saveRefreshToken(String token) =>
      storage.write(key: _kRefreshToken, value: token);

  @override
  Future<String?> getRefreshToken() => storage.read(key: _kRefreshToken);

  @override
  Future<void> clearRefreshToken() => storage.delete(key: _kRefreshToken);
}
