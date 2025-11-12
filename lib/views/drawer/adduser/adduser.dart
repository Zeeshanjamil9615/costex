import 'package:costex_app/views/drawer/adduser/adduser_controller.dart';
import 'package:costex_app/views/home/home.dart';
import 'package:costex_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:costex_app/utils/colour.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddUserController controller = Get.put(AddUserController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
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
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.white, size: 18),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const AppDrawer(), // Your existing drawer from home_page.dart
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.divider,
                      width: 1,
                    ),
                  ),
                ),
                child: const Text(
                  'Add User',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              // Form
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      // Row 1: Full Name, Email, Address
                      _buildResponsiveRow([
                        Expanded(
                          child: CustomTextField(
                            label: 'Full Name',
                            hintText: 'Enter here',
                            controller: controller.fullNameController,
                            required: true,
                            validator: controller.validateFullName,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: HighlightedTextField(
                            label: 'Email',
                            controller: controller.emailController,
                            required: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: controller.validateEmail,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            label: 'Address',
                            hintText: 'Enter Address',
                            controller: controller.addressController,
                            required: true,
                            validator: controller.validateAddress,
                          ),
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // Row 2: Department, Designation, Cell Number
                      _buildResponsiveRow([
                        Expanded(
                          child: CustomTextField(
                            label: 'Department Name',
                            hintText: 'Enter Department Name',
                            controller: controller.departmentController,
                            required: true,
                            validator: controller.validateDepartment,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            label: 'Designation',
                            hintText: 'Designation',
                            controller: controller.designationController,
                            required: true,
                            validator: controller.validateDesignation,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            label: 'Cell Number',
                            hintText: 'Enter Cell No',
                            controller: controller.cellNumberController,
                            required: true,
                            keyboardType: TextInputType.phone,
                            validator: controller.validateCellNumber,
                          ),
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // Row 3: Password (single field)
                      _buildResponsiveRow([
                        Expanded(
                          flex: 1,
                          child: HighlightedTextField(
                            label: 'Password',
                            controller: controller.passwordController,
                            required: true,
                            obscureText: true,
                            validator: controller.validatePassword,
                          ),
                        ),
                        const Expanded(flex: 2, child: SizedBox()),
                      ]),

                      const SizedBox(height: 32),

                      // Add User Button
                      Obx(() => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : controller.addUser,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 48,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 0,
                                disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                              ),
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Add User',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          )),

                      const SizedBox(height: 16),

                      // Red bottom border (decorative)
                      Container(
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8B0000),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveRow(List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile: vertical stack (screen width < 600)
        if (constraints.maxWidth < 600) {
          return Column(
            children: children
                .where((child) => child is! SizedBox || (child.width != 16 && child is Expanded == false))
                .expand((child) {
                  if (child is Expanded && child.child is SizedBox) {
                    return <Widget>[]; // Skip empty expanded widgets
                  }
                  return [
                    child is Expanded ? child.child : child,
                    if (child != children.last && !(child is Expanded && child.child is SizedBox))
                      const SizedBox(height: 16),
                  ];
                })
                .toList(),
          );
        }
        // Tablet/Desktop: horizontal row
        return Row(children: children);
      },
    );
  }
}

// Note: Import AppDrawer from your home_page.dart:
// import 'package:costex_app/pages/home/home_page.dart' show AppDrawer;