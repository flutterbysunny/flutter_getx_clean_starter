import 'package:get/get.dart';
import '../../core/constants/app_routes.dart';
import '../../core/middleware/auth_middleware.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/view/login_view.dart';
import '../modules/auth/view/register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}