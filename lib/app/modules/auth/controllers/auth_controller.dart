import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/network/api_exception.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';


class AuthController extends GetxController {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthController({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase;

  // Form Keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observables
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final errorMessage = ''.obs;
  final currentUser = Rxn<UserEntity>();

  // Toggle Password Visibility
  void togglePasswordVisibility() =>
      isPasswordHidden.value = !isPasswordHidden.value;

  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;

  // Login
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    isLoading.value = true;
    errorMessage.value = '';

    final result = await _loginUseCase(
      LoginParams(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );

    result.fold(
          (ApiException failure) {
        errorMessage.value = failure.message;
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      },
          (UserEntity user) {
        currentUser.value = user;
        Get.offAllNamed(AppRoutes.home);
      },
    );

    isLoading.value = false;
  }

  // Register
  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;

    isLoading.value = true;
    errorMessage.value = '';

    final result = await _registerUseCase(
      RegisterParams(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );

    result.fold(
          (ApiException failure) {
        errorMessage.value = failure.message;
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      },
          (UserEntity user) {
        currentUser.value = user;
        Get.offAllNamed(AppRoutes.home);
      },
    );

    isLoading.value = false;
  }

  // Logout
  Future<void> logout() async {
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }

  // Validators
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}