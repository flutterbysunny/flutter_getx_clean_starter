import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({
    required this.message,
    this.statusCode,
  });

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        return ApiException(
          message: error.response?.data['message'] ?? 'Server error',
          statusCode: error.response?.statusCode,
        );
      default:
        return ApiException(message: 'Something went wrong');
    }
  }

  @override
  String toString() => message;
}