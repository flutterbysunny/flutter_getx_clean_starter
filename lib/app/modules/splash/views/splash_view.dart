import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
   SplashView({super.key});
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primaryLight,
              AppColors.primaryLighter,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Blob 1 — top right big
            Positioned(
              top: -60,
              right: -60,
              child: _blob(220, AppColors.white.withValues(alpha: 0.08)),
            ),

            // Blob 2 — top right small
            Positioned(
              top: 60,
              right: 20,
              child: _blob(140, AppColors.white.withValues(alpha: 0.12)),
            ),

            // Blob 3 — bottom left
            Positioned(
              bottom: -40,
              left: -40,
              child: _blob(160, AppColors.primary.withValues(alpha: 0.5)),
            ),

            // Blob 4 — bottom right small
            Positioned(
              bottom: 80,
              right: 30,
              child: _blob(70, AppColors.white.withValues(alpha: 0.08)),
            ),

            // Center Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Box
                  _buildLogoBox(),
                  const SizedBox(height: 20),

                  // App Name
                  const Text(
                    'GetX Clean',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle
                  Text(
                    'ARCHITECTURE STARTER',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white.withValues(alpha: 0.7),
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Loading bar
                  _buildLoadingBar(),
                ],
              ),
            ),

            // Version
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Text(
                'v1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.white.withValues(alpha: 0.4),
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _buildLogoBox() {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: AppColors.white.withValues(alpha: 0.15),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: const Icon(
        Icons.layers_outlined,
        size: 44,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildLoadingBar() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) {
        return Column(
          children: [
            SizedBox(
              width: 60,
              height: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: AppColors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}