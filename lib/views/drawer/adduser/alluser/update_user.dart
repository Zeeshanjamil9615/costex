

import 'package:costex_app/utils/colour.dart';
import 'package:costex_app/views/drawer/adduser/alluser/all_user_controller.dart';
import 'package:costex_app/views/drawer/adduser/alluser/update_user_controller.dart';
import 'package:costex_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageUserPage extends StatelessWidget {
  final User user;

  const ManageUserPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ManageUserController controller = Get.put(ManageUserController());
    controller.initializeControllers(user);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'MANAGE USERS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Handle logout
            },
            icon: const Icon(Icons.logout, color: Colors.white, size: 18),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: const Text(
                'Update User',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            
            // Form Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Full Name',
                      controller: controller.fullNameController,
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    CustomTextField(
                      label: 'Email',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    CustomTextField(
                      label: 'Address',
                      controller: controller.addressController,
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    CustomTextField(
                      label: 'Department Name',
                      controller: controller.departmentController,
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter department';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    CustomTextField(
                      label: 'Designation',
                      controller: controller.designationController,
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter designation';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    CustomTextField(
                      label: 'Cell Number',
                      controller: controller.cellNumberController,
                      keyboardType: TextInputType.phone,
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter cell number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    CustomTextField(
                      label: 'Password',
                      controller: controller.passwordController,
                      obscureText: true,
                      required: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    
                    // Action Buttons
                    Obx(() => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: controller.updateUser,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF17a2b8),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Update User',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                           
                            ],
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}