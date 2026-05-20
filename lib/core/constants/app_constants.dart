class AppConstants {
  AppConstants._();


  static const String appName = 'GetX Clean Starter';
  static const String baseUrl =
      'https://6a0d9e93769682b8ee76921e.mockapi.io/api/v1';
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';

  // Timeouts
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}