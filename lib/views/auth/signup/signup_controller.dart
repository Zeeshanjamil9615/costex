import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';
import 'package:costex_app/views/auth/login/login.dart';
import 'package:costex_app/views/auth/otp/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final ApiService _apiService = ApiService();

  // Text Controllers
  final companyNameController = TextEditingController();
  final companyAddressController = TextEditingController();
  final companyPhoneController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Observable states
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  @override
  void onClose() {
    companyNameController.dispose();
    companyAddressController.dispose();
    companyPhoneController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Signup function
  Future<void> signup() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final response = await _apiService.registerCompany(
          companyName: companyNameController.text.trim(),
          address: companyAddressController.text.trim(),
          phoneNumber: companyPhoneController.text.trim(),
          username: usernameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        );

        final email = response['email']?.toString() ?? emailController.text.trim();

        Get.snackbar(
          'Success',
          response['message']?.toString() ??
              'Company registered. A verification code has been sent to your email.',
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.symmetric(vertical: 200),
        );

        Get.to(() => OtpVerificationPage(email: email));
      } on ApiException catch (error) {
        Get.snackbar(
          'Error',
          error.message,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.symmetric(vertical: 200),
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Registration failed: $e',
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.symmetric(vertical: 200),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Validators
  String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company name is required';
    }
    if (value.length < 3) {
      return 'Company name must be at least 3 characters';
    }
    return null;
  }

  String? validateCompanyAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company address is required';
    }
    return null;
  }

  String? validateCompanyPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^[\d\s\-\+\(\)]+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Navigate to login
  Future<void> goToLogin() async {
    await SessionService.instance.clearSession();
    Get.offAll(() => const LoginPage());
  }
}