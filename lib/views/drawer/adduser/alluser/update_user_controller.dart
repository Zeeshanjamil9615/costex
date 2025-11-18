// manage_user_page.dart
import 'package:costex_app/api_service/api_service.dart';
import 'package:costex_app/views/drawer/adduser/alluser/all_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageUserController extends GetxController {
  ManageUserController();

  final ApiService _apiService = ApiService();

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController departmentController;
  late TextEditingController designationController;
  late TextEditingController cellNumberController;
  late TextEditingController passwordController;

  final RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  late User _user;

  void initializeControllers(User user) {
    _user = user;
    fullNameController = TextEditingController(text: user.userName);
    emailController = TextEditingController(text: user.email);
    addressController = TextEditingController(text: user.address);
    departmentController = TextEditingController(text: user.department);
    designationController = TextEditingController(text: user.designation);
    cellNumberController = TextEditingController(text: user.cellNo);
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    departmentController.dispose();
    designationController.dispose();
    cellNumberController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> updateUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      final response = await _apiService.updateUser(
        userId: _user.id.toString(),
        fullName: fullNameController.text.trim(),
        cellNumber: cellNumberController.text.trim(),
        address: addressController.text.trim(),
        email: emailController.text.trim(),
        departmentName: departmentController.text.trim(),
        designation: designationController.text.trim(),
        password: passwordController.text.trim(),
      );

      Get.snackbar(
        'Success',
        response['message']?.toString() ?? 'User updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      _refreshUsersList();
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteUser() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      Get.snackbar(
        'Notice',
        'Deletion endpoint not provided yet.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  void _refreshUsersList() {
    if (Get.isRegistered<AllUsersController>()) {
      Get.find<AllUsersController>().refreshUsers();
    }
  }
}