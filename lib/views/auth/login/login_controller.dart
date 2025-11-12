import 'package:costex_app/views/auth/signup/signup.dart';
import 'package:costex_app/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Observable states
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Login function
  Future<void> login() async {
         Get.offAll(() => HomePage());




    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        // TODO: Implement API call
        final loginData = {
          'email': emailController.text,
          'password': passwordController.text,
        };

        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        // Navigate to home on success
        // Get.offAllNamed('/home'); 
         Get.offAll(() => HomePage());

        Get.snackbar(
          'Success',
          'Login successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
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
    // Get.toNamed('/signup'); 
     Get.to(() => SignupPage());
  }

  // Navigate back to home
  void backToHome() {
    // Get.offAllNamed('/home');
      Get.offAll(() => HomePage());
  }
}