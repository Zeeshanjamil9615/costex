import 'package:costex_app/api_service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final ApiService _apiService = ApiService();
  
  // Text Controller
  final emailController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Observable states
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  // Send reset link function
  Future<void> sendResetLink() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        final response = await _apiService.forgotPassword(
          email: emailController.text.trim(),
        );

        // Show success message
        Get.snackbar(
          'Success',
          response['message']?.toString() ?? 
          'Password reset link has been sent to your email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        );

        // Navigate back to login page after showing success
        Future.delayed(const Duration(seconds: 1), () {
          Get.back();
        });
      } on ApiException catch (error) {
        Get.snackbar(
          'Error',
          error.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to send reset link: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Validator
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}

