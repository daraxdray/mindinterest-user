import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TmiLocalStorage {
  TmiLocalStorage() {
    const options = IOSOptions.defaultOptions;

    storage = const FlutterSecureStorage(iOptions: options);
  }
  late FlutterSecureStorage storage;

  Future<void> putData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> getData(String key, {bool isJson = false}) async {
    final data = await storage.read(key: key);
    return data;
  }

  Future<bool> hasKey(String key) async {
    return storage.containsKey(key: key);
  }

  Future<void> deleteData(String key) async {
    await storage.delete(key: key);
  }

  Future<void> clearStorage() async {
    await storage.deleteAll();
  }

  static String kUserDataKey = 'user-data';
}
