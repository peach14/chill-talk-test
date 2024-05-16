import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();
  static final instance = SecureStorage._();

  final String _auth_token = "auth_token";
  final _getIOSOptions =
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  final _getAndroidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  Future<String?> read(String key) async {
    final storage = FlutterSecureStorage();
    return storage.read(
      key: key,
      aOptions: _getAndroidOptions,
      iOptions: _getIOSOptions,
    );
  }

  Future<void> write(String key, String value) async {
    final storage = FlutterSecureStorage();
    await storage.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions,
      iOptions: _getIOSOptions,
    );
  }

  Future<void> delete(String key) async {
    final storage = FlutterSecureStorage();
    await storage.delete(
        key: key, iOptions: _getIOSOptions, aOptions: _getAndroidOptions);
  }

  Future<void> deleteAll() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<void> saveToken(String token) async {
    await write(_auth_token, token);
  }

  Future<void> deleteToken() async {
    await delete(_auth_token);
  }

  Future<String?> getToken() async {
    return await read(_auth_token);
  }
}
