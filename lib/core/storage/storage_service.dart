import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  bool _isLoggedIn = false;



  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // Init — app start pe call hoga
  Future<void> init() async {
    // isLoggedInKey check karo
    final loginState = await read(AppConstants.isLoggedInKey);

    // Token bhi check karo
    final token = await read(AppConstants.tokenKey);

    // Dono check karo
    _isLoggedIn = (loginState == 'true') &&
        (token != null && token.isNotEmpty);

    print('=== STORAGE INIT ===');
    print('loginState: $loginState');
    print('token: $token');
    print('isLoggedIn: $_isLoggedIn');
  }

  // Sync check
  bool isLoggedInSync() => _isLoggedIn;

  // Write
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  // Delete
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // Clear All
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Login state update — sync + storage dono update hoga
  Future<void> writeLoginState(bool value) async {
    _isLoggedIn = value;
    await write(AppConstants.isLoggedInKey, value.toString());
  }

  // Async check via token
  Future<bool> isLoggedIn() async {
    final token = await read(AppConstants.tokenKey);
    return token != null && token.isNotEmpty;
  }
}