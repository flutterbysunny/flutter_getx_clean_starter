import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/api_exception.dart';
import '../models/user_model.dart';

class AuthProvider {
  final Dio _dio = DioClient().dio;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.get('/users');
      final List users = response.data;

      print('Total users: ${users.length}');
      print('First user: ${users.first}');

      final matchedUsers = users.where(
            (u) => u['email'].toString().toLowerCase() ==
            email.toLowerCase(),
      ).toList();

      if (matchedUsers.isEmpty) {
        throw ApiException(message: 'User not found');
      }

      final user = matchedUsers.first;
      if (user['password'].toString() != password) {
        throw ApiException(message: 'Invalid password');
      }

      final userModel = UserModel.fromJson(user);
      return userModel;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: e.toString());
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Saare users fetch karo
      final response = await _dio.get('/users');
      final List users = response.data;

      // Email already exists check
      final exists = users.any(
            (u) => u['email'].toString().toLowerCase() ==
            email.toLowerCase(),
      );

      if (exists) {
        throw ApiException(message: 'Email already exists');
      }

      // New user create karo
      final registerResponse = await _dio.post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'token': 'token_${DateTime.now().millisecondsSinceEpoch}',
          'avatar': '',
        },
      );

      return UserModel.fromJson(registerResponse.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: e.toString());
    }
  }

  Future<bool> logout() async {
    return true;
  }
}