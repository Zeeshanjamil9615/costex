import 'package:costex_app/views/auth/login/login.dart';
import 'package:costex_app/views/auth/otp/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // Text Controllers
  final companyNameController = TextEditingController();
  final companyAddressController = TextEditingController();
  final companyPhoneController = TextEditingController();
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

        // TODO: Implement API call
        final signupData = {
          'companyName': companyNameController.text,
          'companyAddress': companyAddressController.text,
          'companyPhone': companyPhoneController.text,
          'email': emailController.text,
          'password': passwordController.text,
        };

        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        // Show success and navigate to OTP verification
        Get.snackbar(
          'Success',
          'Company registered. A verification code has been sent to your email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        );

        // Navigate to OTP verification page after a short delay
        await Future.delayed(const Duration(seconds: 1));
        // Pass email to OTP page
        Get.to(() => OtpVerificationPage(email: emailController.text));
      } catch (e) {
        Get.snackbar(
          'Error',
          'Registration failed: $e',
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
  void goToLogin() {
    // Get.offAllNamed('/login');
     Get.offAll(() => LoginPage());
  }
}