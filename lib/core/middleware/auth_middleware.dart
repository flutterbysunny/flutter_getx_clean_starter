import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_routes.dart';
import '../storage/storage_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final storageService = Get.find<StorageService>();
    final isLoggedIn = storageService.isLoggedInSync();

    if (!isLoggedIn) {
      return const RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}