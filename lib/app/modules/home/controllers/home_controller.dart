import 'package:get/get.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/storage/storage_service.dart';
import '../../../domain/entities/user_entity.dart';

class HomeController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  final currentUser = Rxn<UserEntity>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  void _loadUser() {
    // Auth controller se user mil jayega
    // Ya storage se load kar sakte ho
  }

  Future<void> logout() async {
    isLoading.value = true;
    await _storageService.clearAll();
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.login);
  }
}