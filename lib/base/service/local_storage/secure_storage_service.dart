import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();
  static final instance = SecureStorage._();

  // ignore: non_constant_identifier_names
  final String _auth_token = "auth_token";
  // ignore: non_constant_identifier_names
  final String _auth_pass = "auth_pass_token";
  final _getIOSOptions =
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  final _getAndroidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  // get
  Future<String?> read(String key) async {
    const storage = FlutterSecureStorage();
    return storage.read(
      key: key,
      aOptions: _getAndroidOptions,
      iOptions: _getIOSOptions,
    );
  }

// save
  Future<void> write(String key, String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions,
      iOptions: _getIOSOptions,
    );
  }

  Future<void> delete(String key) async {
    const storage = FlutterSecureStorage();
    await storage.delete(
        key: key, iOptions: _getIOSOptions, aOptions: _getAndroidOptions);
  }

  Future<void> deleteAll() async {
    const storage = FlutterSecureStorage();
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

  Future<void> savePass(String token) async {
    await write(_auth_pass, token);
  }

  Future<String?> getPass() async {
    return await read(_auth_pass);
  }
}
