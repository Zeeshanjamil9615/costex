// manage_user_page.dart
import 'package:costex_app/views/drawer/adduser/alluser/all_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageUserController extends GetxController {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController departmentController;
  late TextEditingController designationController;
  late TextEditingController cellNumberController;
  late TextEditingController passwordController;

  final RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  void initializeControllers(User user) {
    fullNameController = TextEditingController(text: user.userName);
    emailController = TextEditingController(text: user.email);
    addressController = TextEditingController(text: user.address);
    departmentController = TextEditingController(text: user.department);
    designationController = TextEditingController(text: user.designation);
    cellNumberController = TextEditingController(text: user.cellNo);
    passwordController = TextEditingController(text: user.password);
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

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;

    Get.snackbar(
      'Success',
      'User updated successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
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
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      isLoading.value = false;

      Get.snackbar(
        'Success',
        'User deleted successfully',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        icon: const Icon(Icons.delete, color: Colors.white),
      );

      Get.back(); // Go back to users list
    }
  }
}