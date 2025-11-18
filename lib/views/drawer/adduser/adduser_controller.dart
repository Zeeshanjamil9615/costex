import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/services/session_service.dart';
import 'package:costex_app/views/drawer/adduser/alluser/all_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  final ApiService _apiService = ApiService();
  final SessionService _session = SessionService.instance;
  // Text Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final departmentController = TextEditingController();
  final designationController = TextEditingController();
  final cellNumberController = TextEditingController();
  final passwordController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Loading state
  final isLoading = false.obs;

  @override
  void onClose() {
    // Dispose controllers
    fullNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    departmentController.dispose();
    designationController.dispose();
    cellNumberController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Validate and add user
  Future<void> addUser() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final companyId = _session.companyId;
        final companyName = _session.companyName;

        if (companyId == null) {
          throw Exception('No company information found. Please login again.');
        }

        final response = await _apiService.addUser(
          companyId: companyId,
          companyName: companyName,
          fullName: fullNameController.text.trim(),
          email: emailController.text.trim(),
          address: addressController.text.trim(),
          departmentName: departmentController.text.trim(),
          designation: designationController.text.trim(),
          cellNumber: cellNumberController.text.trim(),
          password: passwordController.text.trim(),
        );

        Get.snackbar(
          'Success',
          response['message']?.toString() ?? 'User added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        clearForm();
        _notifyUsersPage();
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Clear form
  void clearForm() {
    fullNameController.clear();
    emailController.clear();
    addressController.clear();
    departmentController.clear();
    designationController.clear();
    cellNumberController.clear();
    passwordController.clear();
  }

  void _notifyUsersPage() {
    if (Get.isRegistered<AllUsersController>()) {
      Get.find<AllUsersController>().refreshUsers();
    }
  }

  // Validators
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 3) {
      return 'Full name must be at least 3 characters';
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

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  String? validateDepartment(String? value) {
    if (value == null || value.isEmpty) {
      return 'Department name is required';
    }
    return null;
  }

  String? validateDesignation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Designation is required';
    }
    return null;
  }

  String? validateCellNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cell number is required';
    }
    final phoneRegex = RegExp(r'^[\d\s\-\+\(\)]+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid cell number';
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
}