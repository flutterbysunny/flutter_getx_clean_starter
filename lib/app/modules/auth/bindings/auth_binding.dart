import 'package:get/get.dart';
import '../../../../core/storage/storage_service.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../domain/repositories/auth_repository_impl.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Provider
    Get.lazyPut<AuthProvider>(() => AuthProvider());

    // Repository
    Get.lazyPut<AuthRepositoryImpl>(
          () => AuthRepositoryImpl(
        authProvider: Get.find<AuthProvider>(),
        storageService: Get.find<StorageService>(),
      ),
    );

    // UseCases
    Get.lazyPut<LoginUseCase>(
          () => LoginUseCase(Get.find<AuthRepositoryImpl>()),
    );
    Get.lazyPut<RegisterUseCase>(
          () => RegisterUseCase(Get.find<AuthRepositoryImpl>()),
    );

    // Controller
    Get.lazyPut<AuthController>(
          () => AuthController(
        loginUseCase: Get.find<LoginUseCase>(),
        registerUseCase: Get.find<RegisterUseCase>(),
      ),
    );
  }
}