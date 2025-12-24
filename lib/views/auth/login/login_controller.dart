import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';
import 'package:costex_app/views/auth/forgot_password/forgot_password.dart';
import 'package:costex_app/views/auth/signup/signup.dart';
import 'package:costex_app/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  final SessionService _session = SessionService.instance;
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Observable states
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    _prefillEmail();
    _redirectIfLoggedIn();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Login function
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        final response = await _apiService.login(
          username: emailController.text.trim(),
          password: passwordController.text,
        );

        await _session.saveCompanyData(
          (response['data'] as Map<String, dynamic>?)?.map(
                (key, value) => MapEntry(key.toString(), value),
              ) ??
              {},
        );
        await _session.saveUserEmail(emailController.text.trim());

        Get.snackbar(
          'Success',
          response['message']?.toString() ?? 'Login successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
        );

        Get.offAll(() => const HomePage());
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
          'Login failed: $e',
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

  // Validators
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Navigate to signup
  void goToSignup() {
    Get.to(() => SignupPage());
  }

  // Navigate to forgot password
  void goToForgotPassword() {
    Get.to(() => const ForgotPasswordPage());
  }

  void _prefillEmail() {
    final savedEmail = _session.userEmail;
    if (savedEmail != null && savedEmail.isNotEmpty) {
      emailController.text = savedEmail;
    }
  }

  void _redirectIfLoggedIn() {
    if (_session.hasActiveSession) {
      Future.microtask(() => Get.offAll(() => const HomePage()));
    }
  }
}